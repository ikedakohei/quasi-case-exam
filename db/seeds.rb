1.upto 100 do |n|
  Project.create(name: "プロジェクト#{n}", content: "内容#{n}")
end