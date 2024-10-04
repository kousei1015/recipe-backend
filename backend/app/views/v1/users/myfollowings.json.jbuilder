json.array! @relationships.includes(:followed) do |relationship|
    json.id relationship.id
    json.follower_id relationship.follower_id
    json.followed_id relationship.followed_id
    json.user_name relationship.followed.name
    json.avatar_url relationship.followed.avatar_url

    json.already_following true
end