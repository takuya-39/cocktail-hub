server '35.74.20.175',
user: "test_user",
roles: %w{app db web},
ssh_options: {
  user: "test_user",
  keys: %w(~/.ssh/cocktail-hub-ssh.pem),
  forward_agent: true,
  port: 22
}