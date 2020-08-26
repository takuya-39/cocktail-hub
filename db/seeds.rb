if Rails.env == 'development'

  # ゲストユーザーを作成する
  user = User.create!(
    username:              'ゲストユーザー',
    email:                 'guest@example.com',
    password:              'password',
    password_confirmation: 'password',
  )
  user.image.attach(io: File.open('app/assets/images/default_user_image.png'), filename: 'default_user_image.png')

  # サンプルのユーザーを1人作成する
  user = User.create!(
    username:              "ユーザーA",
    email:                 "user@example.com",
    password:              "password",
    password_confirmation: "password",
  )
  user.image.attach(io: File.open('app/assets/images/sample_user_image.jpg'), filename: 'sample_user_image.jpg')

  # ゲストユーザーの投稿を作成する
  post = Post.new(
    id: 1,
    title: 'ゲストユーザーの投稿',
    genre: 'ウイスキー',
    ingredients: '材料',
    memo: '作り方メモ',
    user_id: 1
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/sample_user_image.jpg'), filename: 'sample_user_image.jpg')

  # ユーザーAの投稿を作成する
  post = Post.new(
    id: 2,
    title: 'ユーザーAの投稿',
    genre: 'ウイスキー',
    ingredients: '材料',
    memo: '作り方メモ',
    user_id: 2
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/sample_user_image.jpg'), filename: 'sample_user_image.jpg')
end


if Rails.env == 'production'
end