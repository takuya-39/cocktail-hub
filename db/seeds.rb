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
  # ゲストユーザーの投稿を作成する
  post = Post.new(
    id: 1,
    title: 'ホットココアスキー',
    genre: 'ウイスキー',
    ingredients:
      "・ウイスキー 30ml \n・ココアパウダー 5g \n・お湯 100ml".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "耐熱グラスにココアパウダーを入れて、 \nお湯で溶かしてウイスキーを入れて完成です！寒い日におすすめ！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 2
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/guest_user_post_image1.jpg'), filename: 'guest_user_post_image1.jpg')

  # takuyaの投稿を作成する
  post = Post.new(
    id: 2,
    title: '塩エルディアブロ',
    genre: 'テキーラ',
    ingredients:
      "・テキーラ 50ml \n・カシスリキュール 20ml \n・ジンジャーエール 適量 \n・塩(縁に付けるかそのまま入れる) 5g \n・カットライム、ライム果汁 お好みで量を調整".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "テキーラとカシスを混ぜてジンジャーエールで割ります、 \n塩とライムを入れて完成です！ \n塩とライムの量多めでよりさっぱりとした仕上がりになります！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 3
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_a_post_image1.jpg'), filename: 'user_a_post_image1.jpg')

  # いっしーの投稿を作成する
  post = Post.new(
    id: 3,
    title: 'お手軽サングリア',
    genre: 'ワイン',
    ingredients:
      "・赤ワイン 半分 \n・オランジーナ 半分".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      '赤ワインとオランジーナを一対一で割るだけ！簡単で美味しいよ！',
    user_id: 4
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_b_post_image1.jpg'), filename: 'user_b_post_image1.jpg')

  # ユウタロウの投稿を作成する
  post = Post.new(
    id: 4,
    title: '超辛口ジンジャーハイボール',
    genre: 'ウイスキー',
    ingredients:
      "・ウイスキー 50ml \n・炭酸水 150ml \n・すりおろし生姜 適量 \n・タバスコ お好みの量".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "超辛口のジンジャーハイボールです！！ \n甘さを抑える為にあえてジンジャーエールは使ってません（笑） \n辛くて喉越しスッキリです！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 5
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_c_post_image1.jpg'), filename: 'user_c_post_image1.jpg')

  # 安永の投稿を作成する
  post = Post.new(
    id: 5,
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
    id: 6,
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
    id: 7,
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

  # 追加でゲストユーザーの投稿を作成する
  post = Post.new(
    id: 8,
    title: 'バニラクリームビール',
    genre: 'ビール',
    ingredients:
      "・ビール 350ml(お好きなものを) \n・バニラアイス お好みの量".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "お好きなビールにバニラアイスを豪快に！ \n斬新な味わいです、ビールが好きで甘党な方は是非一度どうぞ！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 2
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/guest_user_post_image2.jpg'), filename: 'guest_user_post_image2.jpg')

  post = Post.new(
    id: 9,
    title: 'はちみつレモンソルティードッグ',
    genre: 'ウォッカ',
    ingredients:
      "・ウォッカ 30ml \n・グレープフルーツジュース 70ml \n・レモン果汁 お好みの量 \n・塩 多めにグラスの縁につける \n・はちみつ お好みの量".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "はちみつレモンの甘さが塩でシャキッと引き締まります！ \n甘さとのバランスを取るために塩は是非多めにつけてみてください！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 2
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/guest_user_post_image3.jpg'), filename: 'guest_user_post_image3.jpg')

  post = Post.new(
    id: 10,
    title: '沖縄風黒糖ブランデーストレート',
    genre: 'ブランデー',
    ingredients:
      "・ブランデー 30ml \n・粉末黒糖 10g".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "ストレートのブランデーに黒糖を加えただけのシンプルなカクテルです、 \nクセのある味わいをお楽しみください！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 2
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/guest_user_post_image4.jpg'), filename: 'guest_user_post_image4.jpg')

  # 追加でtakuyaの投稿を作成する
  post = Post.new(
    id: 11,
    title: '洋梨のジンバック',
    genre: 'ジン',
    ingredients:
      "・ジン 30ml \n・ジンジャーエール 70ml \n・炭酸水 50ml\n・洋梨シロップ 少々".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "ジンバックに洋梨の甘みが加わることでより爽やかな風味が広がります！ \n洋梨シロップ、あまり見かけませんが是非試してみてください！ \n".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 3
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_a_post_image2.jpg'), filename: 'user_a_post_image2.jpg')

  post = Post.new(
    id: 12,
    title: '日本酒サイダー',
    genre: '日本酒',
    ingredients:
      "・三ツ矢サイダー 70ml \n・日本酒 30ml".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "甘めのスパークリング日本酒が飲みたいと思い、 \n試しに作ってみたら意外にも美味しかったのでシェアします(笑) \nお好みでレモンなどを加えてもいいかもしれません。".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 3
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_a_post_image3.jpg'), filename: 'user_a_post_image3.jpg')

  # 追加でいっしーの投稿を作成する
  post = Post.new(
    id: 13,
    title: '健康を考えたオイルトマト焼酎',
    genre: '焼酎',
    ingredients:
      "・焼酎 30ml \n・トマトジュース 70ml \n・オリーブオイル 少々 \n・オレンジ 2切れ".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "お酒を飲む時に少しでも健康に気を遣いたいと思い作ってみました！ \n割とおしゃれな味がします！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 4
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_b_post_image2.jpg'), filename: 'user_b_post_image2.jpg')

  post = Post.new(
    id: 14,
    title: 'さっぱりとしたテキーラウーロン',
    genre: 'テキーラ',
    ingredients:
      "・テキーラ 30ml \n・烏龍茶 70ml \n・レモン果汁 多めに".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "さっぱりとした味わいです！ \nレモン果汁を多めに入れるとより飲みやすくなります！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 4
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_b_post_image3.jpg'), filename: 'user_b_post_image3.jpg')

  # 追加でユウタロウの投稿を作成する
  post = Post.new(
    id: 15,
    title: '大人のレモンティー',
    genre: 'ウイスキー',
    ingredients:
      "・ウイスキー 30ml \n・レモンティー 70ml \n・レモン 一切れ \n・フルーツビネガー 小さじ1杯".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "レモンティーウイスキーを作ってみました！ \nフルーツビネガーの酸味で後味が上品に広がります。".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 5
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_c_post_image2.jpg'), filename: 'user_c_post_image2.jpg')

  post = Post.new(
    id: 16,
    title: 'しっかり甘い、白桃酒カルピス',
    genre: '果実酒',
    ingredients:
      "・白桃酒 20ml \n・カルピス 60ml \n".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    memo:
      "爽やかな甘さでとても美味しいです！ \n市販の桃のカルピスのお酒版です！！".gsub(/(\\r\\n|\\r|\\n)/, "\n"),
    user_id: 5
  )
  post.save!(validate: false)
  post.image.attach(io: File.open('app/assets/images/user_c_post_image3.jpg'), filename: 'user_c_post_image3.jpg')

# 投稿へのいいねを作成する
  # ゲストユーザーが全ての投稿へいいねする
  (1..16).each do |i|
    Like.create!(post_id: i, user_id: 2)
  end

  # takuyaが全ての投稿へいいねする
  (1..16).each do |i|
    Like.create!(post_id: i, user_id: 3)
  end

  # いっしーが一部の投稿へいいねする
  (1..16).each do |i|
    next if i == 2
    next if i == 4
    next if i == 6
    next if i == 8
    next if i == 10
    next if i == 12
    next if i == 14
    next if i == 16
    Like.create!(post_id: i, user_id: 4)
  end

  # ユウタロウが一部の投稿へいいねする
  (1..16).each do |i|
    next if i == 1
    next if i == 3
    next if i == 5
    next if i == 7
    next if i == 9
    next if i == 11
    next if i == 13
    next if i == 15
    Like.create!(post_id: i, user_id: 5)
  end

  # 安永が一部の投稿へいいねする
  (1..3).each do |i|
    Like.create!(post_id: i, user_id: 6)
  end

  # seiraが一部の投稿へいいねする
  (1..2).each do |i|
    Like.create!(post_id: i, user_id: 7)
  end

  # YUIが一部の投稿へいいねする
  Like.create!(post_id: 1, user_id: 8)

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
  (1..16).each do |i|
    Comment.create!(
      post_id: i,
      user_id: 2,
      content: 'すごく美味しそう！'
    )
    Comment.create!(
      post_id: i,
      user_id: 3,
      content: '作ってみたくなりますね！'
    )
    Comment.create!(
      post_id: i,
      user_id: 4,
      content: 'おしゃれ！！'
    )
    Comment.create!(
      post_id: i,
      user_id: 5,
      content: 'アイデアがおもしろいと思います！'
    )
    Comment.create!(
      post_id: i,
      user_id: 6,
      content: '実際に作ってみたけど美味しかったです！'
    )
  end

  # ページネーション表示確認の為にゲストユーザーの投稿にサンプルコメントを50個作成する
  50.times do |n|
    Post.find_by(id: 1).comments.create!(
        user_id: 2,
        content: "ページネーション表示確認用サンプルコメント#{n}"
    )
  end
