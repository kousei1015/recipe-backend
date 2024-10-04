json.is_login v1_user_signed_in?

if v1_user_signed_in?
  json.user_id current_v1_user.id
  json.user_name current_v1_user.name
  json.avatar_url current_v1_user.avatar_url
end
