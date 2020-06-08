server '18.179.194.105',
user: "test_user",
roles: %w{app db web},
ssh_options: {
  user: "test_user", # overrides user setting above
  keys: %w(~/.ssh/pictapp-key.pem),
  forward_agent: true
}