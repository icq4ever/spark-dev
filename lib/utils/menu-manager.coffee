SettingsHelper = require './settings-helper'

module.exports =
  # Get root menu
  getMenu: ->
    ideMenu = atom.menu.template.filter (value) ->
      value.label == 'Spark'

    ideMenu[0]

  # Update menu
  update: ->
    ideMenu = @getMenu()

    if SettingsHelper.isLoggedIn()
      # Menu items for logged in user
      username = SettingsHelper.get('username')

      ideMenu.submenu = [{
        label: 'Log out ' + username,
        command: 'spark-dev:logout'
      },{
        type: 'separator'
      },{
        label: 'Select device...',
        command: 'spark-dev:select-device'
      }]

      if SettingsHelper.hasCurrentCore()
        # Menu items depending on current core
        ideMenu.submenu = ideMenu.submenu.concat [{
          label: 'Rename ' + SettingsHelper.get('current_core_name') + '...',
          command: 'spark-dev:rename-device'
        },{
          label: 'Remove ' + SettingsHelper.get('current_core_name') + '...',
          command: 'spark-dev:remove-device'
        },{
          label: 'Show cloud variables and functions',
          command: 'spark-dev:show-cloud-variables-and-functions'
        },{
          label: 'Flash ' + SettingsHelper.get('current_core_name') + ' via the cloud',
          command: 'spark-dev:flash-cloud'
        }]

      ideMenu.submenu = ideMenu.submenu.concat [{
        type: 'separator'
      },{
        label: 'Claim device...',
        command: 'spark-dev:claim-device'
      },{
        label: 'Identify device...',
        command: 'spark-dev:identify-device'
      },{
        label: 'Setup device\'s WiFi...',
        command: 'spark-dev:setup-wifi'
      },{
        type: 'separator'
      },{
        label: 'Compile in the cloud',
        command: 'spark-dev:compile-cloud'
      }]
    else
      # Logged out user can only log in
      ideMenu.submenu = [{
        label: 'Log in to Spark Cloud...',
        command: 'spark-dev:login'
      }]

    ideMenu.submenu = ideMenu.submenu.concat [{
      type: 'separator'
    },{
      label: 'Show serial monitor',
      command: 'spark-dev:show-serial-monitor'
    }]

    # Refresh UI
    atom.menu.update()
