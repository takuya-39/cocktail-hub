# ユーザーを作成する
  # 管理ユーザーを作成する
  user = User.create!(
    username:              '管理ユーザー',
    email:                 'admin@example.com',
    password:              '00000000',
    password_confirmation: '00000000',
    profile:               '管理ユーザーです。',
    admin:                 true
  )
  user.image.attach(io: File.open('app/assets/images/default_user_image.png'), filename: 'default_user_image.png')

  # ゲストユーザーを作成する
  user = User.create!(
    username:              'ゲストユーザー',
    email:                 'guest@example.com',
    password:              'password',
    password_confirmation: 'password',
    profile:               'ゲストユーザーです。'
  )
  user.image.attach(io: File.open('app/assets/images/default_user_image.png'), filename: 'default_user_image.png')

  # ユーザー(takuya)を作成する
  user = User.create!(
    username:              'takuya',
    email:                 'user-a@example.com',
    password:              'password',
    password_confirmation: 'password',
    profile:               'よろしくお願いします！'
  )
  user.image.attach(io: File.open('app/assets/images/user_a_image.jpg'), filename: 'user_a_image.jpg')

  # ユーザー(いっしー)を作成する
  user = User.create!(
    username:              'いっしー',
    email:                 'user-b@example.com',
    password:              'password',
    password_confirmation: 'password',
    profile:               'こんにちは！'
  )
  user.image.attach(io: File.open('app/assets/images/user_b_image.jpg'), filename: 'user_b_image.jpg')

  # ユーザー(ユウタロウ)を作成する
  user = User.create!(
    username:              'ユウタロウ',
    email:                 'user-c@example.com',
    password:              'password',
    password_confirmation: 'password',
    profile:               'お酒が好きです。'
  )
  user.image.attach(io: File.open('app/assets/images/user_c_image.jpg'), filename: 'user_c_image.jpg')

  # ユーザー(安永)を作成する
  user = User.create!(
    username:              '安永',
    email:                 'user-d@example.com',
    password:              'password',
    password_confirmation: 'password',
    profile:               '都内在住の20代の男です！'
  )
  user.image.attach(io: File.open('app/assets/images/user_d_image.jpg'), filename: 'user_d_image.jpg')

  # ユーザー(seira)を作成する
  user = User.create!(
    username:              'seira',
    email:                 'user-e@example.com',
    password:              'password',
    password_confirmation: 'password',
    profile:               '甘いお酒が好きです。'
  )
  user.image.attach(io: File.open('app/assets/images/user_e_image.jpg'), filename: 'user_e_image.jpg')

  # ユーザー(YUI)を作成する
  user = User.create!(
    username:              'YUI',
    email:                 'user-f@example.com',
    password:              'password',
    password_confirmation: 'password',
    profile:               ''
  )
  user.image.attach(io: File.open('app/assets/images/user_f_image.jpg'), filename: 'user_f_image.jpg')

  # ページネーション表示確認の為にサンプルユーザーを10人作成する
  10.times do |n|
    user = User.create!(
      username:              "サンプルユーザー#{ n }",
      email:                 "sample-#{ n }@example.com",
      password:              'password',
      password_confirmation: 'password',
      profile:               "ページネーション表示確認用サンプルユーザー#{ n }です。"
    )
    user.image.attach(io: File.open('app/assets/images/default_user_image.png'), filename: 'default_user_image.png')
  end

# ユーザーの投稿を作成する
  # ページネーション表示確認の為にゲストユーザーのサンプルの投稿を20個作成する
  20.times do |n|
    post = Post.new(
      title: "ページネーション表示確認用サンプル#{ n }",
      genre: 'その他',
      ingredients:
        "・サンプル".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
      memo:
        "サンプル".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
      user_id: 2
    )
    post.save!(validate: false)
    post.image.attach(io: File.open('app/assets/images/sample_user_post_image.jpg'), filename: 'sample_user_post_image.jpg')
  end

  # ゲストユーザーの投稿を作成する
  post = Post.new(
    id: 21,
    title: 'ホットココアスキー',
    genre: 'ウイスキー',
    ingredients:
      "・ウイスキー 30ml \n・ココアパウダー 5g \n・お湯 100ml".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "耐熱グラスにココアパウダーを入れて、 \nお湯で溶かしてウイスキーを入れて完成です！寒い日におすすめ！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 2
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/guest_user_post_image.jpg'), filename: 'guest_user_post_image.jpg')

  # takuyaの投稿を作成する
  post = Post.new(
    id: 22,
    title: '塩エルディアブロ',
    genre: 'テキーラ',
    ingredients:
      "・テキーラ 50ml \n・カシスリキュール 20ml \n・ジンジャーエール 適量 \n・塩(縁に付けるかそのまま入れる) 5g \n・カットライム、ライム果汁 お好みで量を調整".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "テキーラとカシスを混ぜてジンジャーエールで割ります、 \n塩とライムを入れて完成です！ \n塩とライムの量多めでよりさっぱりとした仕上がりになります！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 3
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_a_post_image.jpg'), filename: 'user_a_post_image.jpg')

  # いっしーの投稿を作成する
  post = Post.new(
    id: 23,
    title: 'お手軽サングリア',
    genre: 'ワイン',
    ingredients:
      "・赤ワイン 半分 \n・オランジーナ 半分".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      '赤ワインとオランジーナを一対一で割るだけ！簡単で美味しいよ！',
    user_id: 4
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_b_post_image.jpg'), filename: 'user_b_post_image.jpg')

  # ユウタロウの投稿を作成する
  post = Post.new(
    id: 24,
    title: '超辛口ジンジャーハイボール',
    genre: 'ウイスキー',
    ingredients:
      "・ウイスキー 50ml \n・炭酸水 150ml \n・すりおろし生姜 適量 \n・タバスコ お好みの量".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "超辛口のジンジャーハイボールです！！ \n甘さを抑える為にあえてジンジャーエールは使ってません（笑） \n辛くて喉越しスッキリです！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 5
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_c_post_image.jpg'), filename: 'user_c_post_image.jpg')

  # 安永の投稿を作成する
  post = Post.new(
    id: 25,
    title: 'ラム梅酒~レモン仕立て~',
    genre: 'ラム',
    ingredients:
      "・梅酒  50ml \n・ラム酒 50ml \n・炭酸水 100ml \n・レモン果汁 適量".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "梅酒とラムと炭酸水を混ぜてレモン果汁で仕上げます。 \nラムと梅の甘味がレモンで引き締まって美味しいです。",
    user_id: 6
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_d_post_image.jpg'), filename: 'user_d_post_image.jpg')

  # seiraの投稿を作成する
  post = Post.new(
    id: 26,
    title: 'シナモン香るアップルミルク',
    genre: '果実酒',
    ingredients:
      "・アップルリキュール 50ml \n・牛乳 100ml \n・シナモン 10g".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "アップルリキュール、牛乳、シナモンを混ぜたカクテルです \nまるでアップルパイのような味がします！とっても美味しいです！！",
    user_id: 7
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_e_post_image.jpg'), filename: 'user_e_post_image.jpg')

  # YUIの投稿を作成する
  post = Post.new(
    id: 27,
    title: 'ノンアルコールモヒート',
    genre: 'ノンアルコール',
    ingredients:
      "・炭酸水 200ml \n・砂糖 30g(お好みで調整) \n・ミント 10g \n・ライム果汁 適量".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "お酒が飲めなくても楽しめるノンアルコールのモヒートです。 \n甘い方が好きな方は砂糖の量多めで試してみてください。".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 8
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_f_post_image.jpg'), filename: 'user_f_post_image.jpg')


# 投稿へのいいねを作成する
  # ゲストユーザーが全ての投稿へいいねする
  (21..27).each do |i|
    Like.create!(post_id: i, user_id: 2)
  end

  # takuyaが全ての投稿へいいねする
  (21..27).each do |i|
    Like.create!(post_id: i, user_id: 3)
  end

  # いっしーが一部の投稿へいいねする
  (21..27).each do |i|
    next if i == 22
    next if i == 24
    next if i == 26
    Like.create!(post_id: i, user_id: 4)
  end

  # ユウタロウが一部の投稿へいいねする
  (21..27).each do |i|
    next if i == 21
    next if i == 23
    next if i == 25
    next if i == 27
    Like.create!(post_id: i, user_id: 5)
  end

  # 安永が一部の投稿へいいねする
  (21..23).each do |i|
    Like.create!(post_id: i, user_id: 6)
  end

  # seiraが一部の投稿へいいねする
  (21..22).each do |i|
    Like.create!(post_id: i, user_id: 7)
  end

  # YUIが一部の投稿へいいねする
  Like.create!(post_id: 21, user_id: 8)

# フォロー関係を作成する
  # ゲストユーザーが他の全てのサンプルユーザーをフォローする
  (2..8).each do |i|
    next if i == 2
    Relationship.create!(follow_id: i, user_id: 2)
  end

  # takuyaが他の全てのサンプルユーザーをフォローする
  (2..8).each do |i|
    next if i == 3
    Relationship.create!(follow_id: i, user_id: 3)
  end

  # いっしーが他の全てのサンプルユーザーをフォローする
  (2..8).each do |i|
    next if i == 4
    Relationship.create!(follow_id: i, user_id: 4)
  end

  # ユウタロウが一部のサンプルユーザーをフォローする
  (2..8).each do |i|
    next if i == 3
    next if i == 5
    next if i == 7
    Relationship.create!(follow_id: i, user_id: 5)
  end

  # 安永が一部のサンプルユーザーをフォローする
  (2..8).each do |i|
    next if i == 2
    next if i == 4
    next if i == 6
    next if i == 8
    Relationship.create!(follow_id: i, user_id: 6)
  end

  # seiraが一部のサンプルユーザーをフォローする
  (2..5).each do |i|
    Relationship.create!(follow_id: i, user_id: 7)
  end

  # YUIが一部のサンプルユーザーをフォローする
  (6..7).each do |i|
    Relationship.create!(follow_id: i, user_id: 8)
  end

# コメントを作成する
  # 一部のユーザーが全ての投稿にコメントする
  Post.all.each do |post|
    post.comments.create!(
      user_id: 2,
      content: 'すごく美味しそう！'
    )
    post.comments.create!(
      user_id: 3,
      content: '作ってみたくなりますね！'
    )
    post.comments.create!(
      user_id: 4,
      content: 'おしゃれ！！'
    )
    post.comments.create!(
      user_id: 5,
      content: 'アイデアがおもしろいと思います！'
    )
    post.comments.create!(
      user_id: 6,
      content: '実際に作ってみたけど美味しかったです！'
    )
  end

  # ページネーション表示確認の為にゲストユーザーの投稿にサンプルコメントを50個作成する
  50.times do |n|
    Post.first.comments.create!(
        user_id: 2,
        content: "ページネーション表示確認用サンプルコメント#{n}"
    )
  end
