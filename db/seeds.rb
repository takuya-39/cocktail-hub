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


# ユーザーの投稿を作成する
  # ゲストユーザーの投稿を作成する
  post = Post.new(
    id: 1,
    title: 'ホットココアスキー',
    genre: 'ウイスキー',
    ingredients:
      "・ウイスキー 30ml \n・ココアパウダー 5g \n・お湯 100ml".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "耐熱グラスにココアパウダーを入れて、 \nお湯で溶かしてウイスキーを入れて完成です！寒い日におすすめ！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 1
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/guest_user_post_image.jpg'), filename: 'guest_user_post_image.jpg')

  # takuyaの投稿を作成する
  post = Post.new(
    id: 2,
    title: '塩エルディアブロ',
    genre: 'テキーラ',
    ingredients:
      "・テキーラ 50ml \n・カシスリキュール 20ml \n・ジンジャーエール 適量 \n・塩(縁に付けるかそのまま入れる) 5g \n・カットライム、ライム果汁 お好みで量を調整".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "テキーラとカシスを混ぜてジンジャーエールで割ります、 \n塩とライムを入れて完成です！ \n塩とライムの量多めでよりさっぱりとした仕上がりになります！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 2
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_a_post_image.jpg'), filename: 'user_a_post_image.jpg')

  # いっしーの投稿を作成する
  post = Post.new(
    id: 3,
    title: 'お手軽サングリア',
    genre: 'ワイン',
    ingredients:
      "・赤ワイン 半分 \n・オランジーナ 半分".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      '赤ワインとオランジーナを一対一で割るだけ！簡単で美味しいよ！',
    user_id: 3
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_b_post_image.jpg'), filename: 'user_b_post_image.jpg')

  # ユウタロウの投稿を作成する
  post = Post.new(
    id: 4,
    title: '超辛口ジンジャーハイボール',
    genre: 'ウイスキー',
    ingredients:
      "・ウイスキー 50ml \n・炭酸水 150ml \n・すりおろし生姜 適量 \n・タバスコ お好みの量".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "超辛口のジンジャーハイボールです！！ \n甘さを抑える為にあえてジンジャーエールは使ってません（笑） \n辛くて喉越しスッキリです！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 4
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_c_post_image.jpg'), filename: 'user_c_post_image.jpg')

  # 安永の投稿を作成する
  post = Post.new(
    id: 5,
    title: 'ラム梅酒~レモン仕立て~',
    genre: 'ラム',
    ingredients:
      "・梅酒  50ml \n・ラム酒 50ml \n・炭酸水 100ml \n・レモン果汁 適量".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "梅酒とラムと炭酸水を混ぜてレモン果汁で仕上げます。 \nラムと梅の甘味がレモンで引き締まって美味しいです。",
    user_id: 5
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_d_post_image.jpg'), filename: 'user_d_post_image.jpg')

  # seiraの投稿を作成する
  post = Post.new(
    id: 6,
    title: 'シナモン香るアップルミルク',
    genre: '果実酒',
    ingredients:
      "・アップルリキュール 50ml \n・牛乳 100ml \n・シナモン 10g".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "アップルリキュール、牛乳、シナモンを混ぜたカクテルです \nまるでアップルパイのような味がします！とっても美味しいです！！",
    user_id: 6
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_e_post_image.jpg'), filename: 'user_e_post_image.jpg')

  # YUIの投稿を作成する
  post = Post.new(
    id: 7,
    title: 'ノンアルコールモヒート',
    genre: 'ノンアルコール',
    ingredients:
      "・炭酸水 200ml \n・砂糖 30g(お好みで調整) \n・ミント 10g \n・ライム果汁 適量".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "お酒が飲めなくても楽しめるノンアルコールのモヒートです。 \n甘い方が好きな方は砂糖の量多めで試してみてください。".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 7
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_f_post_image.jpg'), filename: 'user_f_post_image.jpg')


# 投稿へのいいねを作成する
  # ゲストユーザーが全てのサンプルユーザーの投稿へいいねする
  (1..7).each do |i|
    Like.create!(post_id: i, user_id: 1)
  end

  # takuyaが全てのサンプルユーザーの投稿へいいねする
  (1..7).each do |i|
    Like.create!(post_id: i, user_id: 2)
  end

  # いっしーが一部のサンプルユーザーの投稿へいいねする
  (1..7).each do |i|
    next if i == 1
    next if i == 3
    next if i == 5
    next if i == 7
    Like.create!(post_id: i, user_id: 3)
  end

  # ユウタロウが一部のサンプルユーザーの投稿へいいねする
  (1..7).each do |i|
    next if i == 2
    next if i == 4
    next if i == 6
    Like.create!(post_id: i, user_id: 4)
  end

  # 安永が他の全てのサンプルユーザーの投稿へいいねする
  (1..7).each do |i|
    next if i == 5
    Like.create!(post_id: i, user_id: 5)
  end

  # seiraが一部のサンプルユーザーの投稿へいいねする
  (1..4).each do |i|
    Like.create!(post_id: i, user_id: 6)
  end

  # YUIが一部のサンプルユーザーの投稿へいいねする
  (5..7).each do |i|
    Like.create!(post_id: i, user_id: 7)
  end

# フォロー関係を作成する
  # ゲストユーザーが他の全てのサンプルユーザーをフォローする
  (1..7).each do |i|
    next if i == 1
    Relationship.create!(follow_id: i, user_id: 1)
  end

  # takuyaが他の全てのサンプルユーザーをフォローする
  (1..7).each do |i|
    next if i == 2
    Relationship.create!(follow_id: i, user_id: 2)
  end

  # いっしーが他の全てのサンプルユーザーをフォローする
  (1..7).each do |i|
    next if i == 3
    Relationship.create!(follow_id: i, user_id: 3)
  end

  # ユウタロウが一部のサンプルユーザーをフォローする
  (1..7).each do |i|
    next if i == 2
    next if i == 4
    next if i == 6
    Relationship.create!(follow_id: i, user_id: 4)
  end

  # 安永が一部のサンプルユーザーをフォローする
  (1..7).each do |i|
    next if i == 1
    next if i == 3
    next if i == 5
    next if i == 7
    Relationship.create!(follow_id: i, user_id: 5)
  end

  # seiraが一部のサンプルユーザーをフォローする
  (1..4).each do |i|
    Relationship.create!(follow_id: i, user_id: 6)
  end

  # YUIが一部のサンプルユーザーをフォローする
  (5..6).each do |i|
    Relationship.create!(follow_id: i, user_id: 7)
  end

# コメントを作成する
  # 一部のユーザーが全ての投稿にコメントする
  Post.all.each do |post|
    post.comments.create!(
      user_id: 1,
      content: 'すごく美味しそう！'
    )
    post.comments.create!(
      user_id: 2,
      content: '作ってみたくなりますね！'
    )
    post.comments.create!(
      user_id: 3,
      content: 'おしゃれ！！'
    )
    post.comments.create!(
      user_id: 4,
      content: 'アイデアがおもしろいと思います！'
    )
    post.comments.create!(
      user_id: 5,
      content: '実際に作ってみたけど美味しかったです！'
    )
  end

  # コメント部分のページネーションを表示する為、最初の投稿にサンプルコメントを複数作成する
  50.times do |n|
    Post.first.comments.create!(
        user_id: 1,
        content: "サンプルコメント#{n}"
    )
  end