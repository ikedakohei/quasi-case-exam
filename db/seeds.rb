# user_id: 1のアカウントが作成済みであること
1.upto 10 do |n|
  Project.create(name: "ユーザ1:プロジェクト#{n}", content: "内容#{n}", user_id: 1)
end
# user_id: 2のアカウントが作成済みであること
1.upto 10 do |n|
  Project.create(name: "ユーザ2:プロジェクト#{n}", content: "内容#{n}", user_id: 2)
end
# user_id: 3のアカウントが作成済みであること
1.upto 8 do |n|
  Project.create(name: "ユーザ3:プロジェクト#{n}", content: "内容#{n}", user_id: 3)
end
