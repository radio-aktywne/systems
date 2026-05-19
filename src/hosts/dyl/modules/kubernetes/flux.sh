#!/usr/bin/env bash

### CONFIGURATION ###

INSTANCE_MANIFEST_FILE='@instanceManifestFile@'
KUBECONFIG='@kubeconfig@'
NODE='@node@'
OPERATOR_VERSION='@operatorVersion@'
SOPS_KEYS_FILE='@sopsKeysFile@'

### MAIN ###

printf '%s\n' 'Waiting for DNS to be ready'

for i in $(seq 1 300); do
	pods="$(kubectl --kubeconfig "${KUBECONFIG}" get pods --namespace kube-system --selector k8s-app=kube-dns --field-selector status.phase=Running --template='{{.items | len}}')"

	if [[ ${pods} -gt 0 ]]; then
		break
	fi

	if [[ ${i} -eq 300 ]]; then
		printf '%s\n' 'DNS not ready' >&2
		exit 1
	fi

	sleep 1
done

if ! kubectl --kubeconfig "${KUBECONFIG}" wait --for condition=Ready --timeout 5m --namespace kube-system pods --selector k8s-app=kube-dns --field-selector status.phase=Running >/dev/null; then
	printf '%s\n' 'DNS not ready' >&2
	exit 1
fi

printf '%s\n' 'DNS ready'

printf '%s\n' 'Installing Flux Operator'

if ! helm --kubeconfig "${KUBECONFIG}" upgrade --install flux-operator oci://ghcr.io/controlplaneio-fluxcd/charts/flux-operator --version "${OPERATOR_VERSION}" --namespace flux-system --create-namespace --set apiPriority.enabled=true --wait; then
	printf '%s\n' 'Flux Operator installation failed' >&2
	exit 2
fi

printf '%s\n' 'Flux Operator installed'

printf '%s\n' 'Adding SOPS keys secret'

if ! manifest="$(kubectl --kubeconfig "${KUBECONFIG}" create secret generic sops-keys --namespace flux-system --from-file "sops.agekey=${SOPS_KEYS_FILE}" --dry-run=client --save-config --output yaml)"; then
	printf '%s\n' 'Secret manifest creation failed' >&2
	exit 3
fi

if ! kubectl --kubeconfig "${KUBECONFIG}" apply --filename <(printf '%s' "${manifest}"); then
	printf '%s\n' 'Secret creation failed' >&2
	exit 4
fi

printf '%s\n' 'Secret added'

printf '%s\n' 'Adding node labels'

if ! kubectl --kubeconfig "${KUBECONFIG}" label --overwrite node "${NODE}" 'node.longhorn.io/create-default-disk=true'; then
	printf '%s\n' 'Node label addition failed' >&2
	exit 5
fi

printf '%s\n' 'Node labels added'

printf '%s\n' 'Creating Flux instance'

if ! kubectl --kubeconfig "${KUBECONFIG}" apply --filename "${INSTANCE_MANIFEST_FILE}"; then
	printf '%s\n' 'Flux instance creation failed' >&2
	exit 6
fi

printf '%s\n' 'Flux instance created'

printf '%s\n' 'Waiting for Flux instance to become ready'

if ! kubectl --kubeconfig "${KUBECONFIG}" wait --for condition=Ready --timeout 5m --namespace flux-system fluxinstance/flux >/dev/null; then
	printf '%s\n' 'Flux instance not ready' >&2
	exit 7
fi

printf '%s\n' 'Flux instance ready'
