# Users configuration
{
  users = {
    # Don't allow changing users configuration during runtime
    mutableUsers = false;

    users = {
      root = {
        # This is just for demonstration purposes
        # Don't do it like this in practice
        password = "root";
      };
    };
  };
}
