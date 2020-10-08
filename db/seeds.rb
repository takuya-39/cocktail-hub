if Rails.env == 'development'

  # ユーザーを作成する
    # ゲストユーザーを作成する
    user = User.create!(
      username:              'ゲストユーザー',
      email:                 'guest@example.com',
      password:              'password',
      password_confirmation: 'password',
    )
    user.image.attach(io: File.open('app/assets/images/default_user_image.png'), filename: 'default_user_image.png')

    # ユーザーAを作成する
    user = User.create!(
      username:              "ユーザーA",
      email:                 "user-a@example.com",
      password:              "password",
      password_confirmation: "password",
    )
    user.image.attach(io: File.open('app/assets/images/sample_user_image_cat.jpg'), filename: 'sample_user_image_cat.jpg')

    # ユーザーBを作成する
    user = User.create!(
      username:              "ユーザーB",
      email:                 "user-b@example.com",
      password:              "password",
      password_confirmation: "password",
    )
    user.image.attach(io: File.open('app/assets/images/sample_user_image_dog.jpg'), filename: 'sample_user_image_dog.jpg')

    # ユーザーCを作成する
    user = User.create!(
      username:              "ユーザーC",
      email:                 "user-c@example.com",
      password:              "password",
      password_confirmation: "password",
    )
    user.image.attach(io: File.open('app/assets/images/sample_user_image_nature.jpg'), filename: 'sample_user_image_nature.jpg')


  # ユーザーの投稿を作成する
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
    post.image.attach(io: File.open('app/assets/images/sample_post_image1.jpg'), filename: 'sample_post_image1.jpg')

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
    post.image.attach(io: File.open('app/assets/images/sample_post_image2.jpg'), filename: 'sample_post_image2.jpg')

    # ユーザーBの投稿を作成する
    post = Post.new(
      id: 3,
      title: 'ユーザーBの投稿',
      genre: 'ビール',
      ingredients: '材料',
      memo: '作り方メモ',
      user_id: 3
    )
    post.save!(validate: false)
    post.image.attach(io: File.open('app/assets/images/sample_post_image3.jpg'), filename: 'sample_post_image3.jpg')

    # ユーザーCの投稿を作成する
    post = Post.new(
      id: 4,
      title: 'ユーザーCの投稿',
      genre: '焼酎',
      ingredients: '材料',
      memo: '作り方メモ',
      user_id: 4
    )
    post.save!(validate: false)
    post.image.attach(io: File.open('app/assets/images/sample_post_image4.jpg'), filename: 'sample_post_image4.jpg')

  # フォロー関係を作成する
    # ゲストユーザーが全てのユーザーをフォローする
    Relationship.create!(
      [
        {
          follow_id: 2,
          user_id: 1
        },
        {
          follow_id: 3,
          user_id: 1
        },
        {
          follow_id: 4,
          user_id: 1
        },
      ]
    )

    # ユーザーAが全てのユーザーをフォローする
    Relationship.create!(
      [
        {
          follow_id: 1,
          user_id: 2
        },
        {
          follow_id: 3,
          user_id: 2
        },
        {
          follow_id: 4,
          user_id: 2
        },
      ]
    )

    # ユーザーBが全てのユーザーをフォローする
    Relationship.create!(
      [
        {
          follow_id: 1,
          user_id: 3
        },
        {
          follow_id: 2,
          user_id: 3
        },
        {
          follow_id: 4,
          user_id: 3
        },
      ]
    )

    # ユーザーCが全てのユーザーをフォローする
    Relationship.create!(
      [
        {
          follow_id: 1,
          user_id: 4
        },
        {
          follow_id: 2,
          user_id: 4
        },
        {
          follow_id: 3,
          user_id: 4
        },
      ]
    )

    # ゲストユーザーが全ての投稿にコメントする
    Post.all.each do |post|
      post.comments.create!(
        user_id: 1,
        content: 'ゲストユーザーのコメント'
      )
    end
end


if Rails.env == 'production'
end