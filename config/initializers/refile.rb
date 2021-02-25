require "refile/s3"

aws = {
  access_key_id: 'AKIARHY6H6UNK6RSTWMA',
  secret_access_key: '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',
  region: "ap-northeast-1",
  bucket: "studio--dig",
}
Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
