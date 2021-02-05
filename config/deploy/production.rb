server "13.114.137.72", user: "ec2-user", roles: %w{web app},
  ssh_options: {
    user: "user_name", # overrides user setting above
    keys: %w(/home/user_name/.ssh/id_rsa),
    forward_agent: false,
    auth_methods: %w(publickey password)
    # password: "please use keys"
  }
