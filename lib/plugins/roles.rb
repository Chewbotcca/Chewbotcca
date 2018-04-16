module Roles
  extend Discordrb::Commands::CommandContainer

  command(:createrole, min_args: 1, required_permissions: [:manage_roles], permission_message: 'My dude, you do not have permission to manage roles!') do |event, *rolename|
    rolename = rolename.join(' ')
    begin
      role = event.server.create_role
      role.name = rolename
      event.respond "I have successfully created the role `#{rolename}`!"
    rescue Discordrb::Errors::NoPermission
      event.respond "I do not have permission to 'manage roles', can you please provide those, thanks, appreciate ya"
    end
  end

  command(:assignrole, min_args: 2, required_permissions: [:manage_roles], permission_message: 'My dude, you do not have permission to manage roles!') do |event, mention, *rolename|
    id = Bot.parse_mention(mention.to_s).id.to_i
    user = event.server.member(id)
    rolename = rolename.join(' ')
    begin
      therole = event.server.roles.find { |role| role.name == rolename }
      user.add_role(therole)
      event.respond "I have successfully given #{user.distinct} the role `#{rolename}`!"
    rescue Discordrb::Errors::NoPermission
      event.respond "I do not have permission to 'manage roles', can you please provide those, thanks, appreciate ya"
    end
  end

  command(:removerole, min_args: 2, required_permissions: [:manage_roles], permission_message: 'My dude, you do not have permission to manage roles!') do |event, mention, *rolename|
    id = Bot.parse_mention(mention.to_s).id.to_i
    user = event.server.member(id)
    rolename = rolename.join(' ')
    begin
      therole = event.server.roles.find { |role| role.name == rolename }
      user.remove_role(therole)
      event.respond "I have successfully removed #{user.distinct} from the role `#{rolename}`!"
    rescue Discordrb::Errors::NoPermission
      event.respond "I do not have permission to 'manage roles', can you please provide those, thanks, appreciate ya"
    end
  end
end