JsOsaDAS1.001.00bplist00?Vscript_|// Build argv/argc in a way that can be used from the applet inside the app bundle
ObjC.import('Foundation')
const args = $.NSProcessInfo.processInfo.arguments
const argv = []
const argc = args.count
for (let i = 0; i < argc; i++) { argv.push(ObjC.unwrap(args.objectAtIndex(i))) }
delete args

// Notification script
const app = Application.currentApplication()
app.includeStandardAdditions = true

if (argv.length < 2)  { // We use '2' since the script will always see at least one argument: the applet itself
  argv[1] = 'Going to Download Page'

  app.openLocation('https://github.com/MartinGurasvili/BlueBubble')
}

const message = argv[1]
const title = argv[2]
const subtitle = argv[3]
const sound = argv[4]

const options = {}
if (title) options.withTitle = title
if (subtitle) options.subtitle = subtitle
if (sound) options.soundName = sound

app.displayNotification(message, options)
                              ?jscr  ??ޭ