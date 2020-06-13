server '18.179.194.105',
user: "test_user",
roles: %w{app db web},
ssh_options: {
  user: "test_user",
  keys: %w(~/.ssh/cocktail-hub-ssh-key.pem),
  forward_agent: true,
  port: 22
}