json.array! @relationships.includes(:follower) do |relationship|
    json.id relationship.id
    json.follower_id relationship.follower_id
    json.followed_id relationship.followed_id
    json.user_name relationship.follower.name
    json.avatar_url relationship.follower.avatar_url
    
    if current_v1_user
        is_following = current_v1_user.relationships.exists?(followed_id: relationship.follower_id)
        json.already_following is_following
    end
end