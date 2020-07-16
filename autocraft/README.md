### autocraft

Standalone program for requesting crafts from Applied Energetics 2 autocraft system (just so does ME terminal). To install, run

```bash
oppm install autocraft
```

### Hardware Requirements

- ME Controller
- Some wires
- Adapter (one, that interacts with other blocks). To check if it is connected and "sees" the ME Controller, you can run `lua` and paste into terminal this text:

```lua
=component.me_controller
```

- Craft patterns assigned to ME Interfaces (could be of any complexity, just as standard AE2 )
- Have those ME Interfaces connected to Molecular Assemblers and other mechanisms (depends on how much your crafts are perverted ^^), so they can craft. By the way, for some crafts you can use [BuildCraft](https://www.curseforge.com/minecraft/mc-mods/buildcraft/files) pipes to return items back from mechanisms if they cannot return on their own.
- Crafting storage. Capacity also depends on what are you trying to autocraft.