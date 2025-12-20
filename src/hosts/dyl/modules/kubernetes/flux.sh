#!/usr/bin/env bash

### CONFIGURATION ###

KEYS_FILE='@keysFile@'
KUBECONFIG='@kubeconfig@'
NODE='@node@'
SOURCE_BRANCH='@sourceBranch@'
SOURCE_IGNORE='@sourceIgnore@'
SOURCE_PATH='@sourcePath@'
SOURCE_URL='@sourceUrl@'

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

if ! kubectl --kubeconfig "${KUBECONFIG}" wait --for condition=ready pods --namespace kube-system --selector k8s-app=kube-dns --field-selector status.phase=Running >/dev/null; then
	printf '%s\n' 'DNS not ready' >&2
	exit 1
fi

printf '%s\n' 'DNS ready'

printf '%s\n' 'Running checks for Flux'

if ! flux --kubeconfig "${KUBECONFIG}" check --pre; then
	printf '%s\n' 'Flux pre-check failed' >&2
	exit 2
fi

printf '%s\n' 'Checks passed'

printf '%s\n' 'Installing Flux'

if ! flux --kubeconfig "${KUBECONFIG}" install; then
	printf '%s\n' 'Flux installation failed' >&2
	exit 3
fi

printf '%s\n' 'Flux installed'

printf '%s\n' 'Adding SOPS keys secret'

if ! manifest="$(kubectl --kubeconfig "${KUBECONFIG}" create secret generic sops-keys --namespace flux-system --from-file "sops.agekey=${KEYS_FILE}" --dry-run=client --save-config --output yaml)"; then
	printf '%s\n' 'Secret manifest creation failed' >&2
	exit 4
fi

if ! kubectl --kubeconfig "${KUBECONFIG}" apply --filename - <<EOF; then
${manifest}
EOF
	printf '%s\n' 'Secret creation failed' >&2
	exit 5
fi

printf '%s\n' 'Secret added'

printf '%s\n' 'Adding node labels'

if ! kubectl --kubeconfig "${KUBECONFIG}" label --overwrite node "${NODE}" 'node.longhorn.io/create-default-disk=true'; then
	printf '%s\n' 'Node label addition failed' >&2
	exit 6
fi

printf '%s\n' 'Node labels added'

printf '%s\n' 'Creating source'

if ! flux --kubeconfig "${KUBECONFIG}" create source git main --url "${SOURCE_URL}" --branch "${SOURCE_BRANCH}" --ignore-paths "${SOURCE_IGNORE}"; then
	printf '%s\n' 'Flux source creation failed' >&2
	exit 7
fi

printf '%s\n' 'Source created'

printf '%s\n' 'Creating kustomization'

if ! flux --kubeconfig "${KUBECONFIG}" create kustomization main --source main --path "${SOURCE_PATH}" --decryption-provider sops --decryption-secret sops-keys --prune --wait; then
	printf '%s\n' 'Flux kustomization creation failed' >&2
	exit 8
fi

printf '%s\n' 'Kustomization created'
