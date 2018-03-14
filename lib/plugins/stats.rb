module Stats
  extend Discordrb::Commands::CommandContainer

  command :stats do |event|
    t = Time.now - Starttime
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)

    commits = `git rev-list master | wc -l`.to_i
    version = `git describe --abbrev=0 --tags`.to_s

    botversion = if commits.zero? && version.zero?
                   ''
                 elsif version.to_i > 0 && commits.zero?
                   version
                 else
                   "#{version} (Commit: #{commits})"
                 end

    event.channel.send_embed do |e|
      e.title = 'Chewbotcca - A basic, yet functioning, discord bot'

      e.add_field(name: 'Author', value: "Chew#0001\n[116013677060161545]", inline: true)
      e.add_field(name: 'Code', value: '<http://github.com/Chewbotcca/Discord>', inline: true)
      e.add_field(name: 'Bot Version', value: botversion, inline: true) unless botversion == ''
      e.add_field(name: 'Library', value: 'discordrb 3.2.1', inline: true)
      e.add_field(name: 'Server Count', value: event.bot.servers.count, inline: true)
      e.add_field(name: 'Total User Count', value: event.bot.users.count, inline: true)
      e.add_field(name: 'Uptime', value: format('%d days, %d hours, %d minutes and %d seconds', dd, hh, mm, ss), inline: true)
      e.color = '00FF00'
    end
  end
end
