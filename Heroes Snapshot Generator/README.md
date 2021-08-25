# HeroesOfTheStorm_HeroesSnapshotGenerator

A super hard to customize, only fits my needs, Heroes Snapshot Generator!

## Prerequisite

- Heroes of the Storm installed in `C:/Program Files/Heroes of the Storm`
- WSL
  - storm-extract (see the another tool, storm-extract Setup)

## Batch files:

Each of the batch files will ask a series of questions:

![Batch Screen](https://i.imgur.com/RmvaaVy.png)

- Extracting PTR
- Folder Name
- XSD Generation (Another Tool, XSD Schema Generator scripts must be placed on the same directory)
- Whether to Shutdown the computer if completed

### HeroesSnapshotGenerator

Extract game files and output to two folders:
 - `HeroesSnapshot_{Game Version}_{Folder Name}`: ALL game files 
 - `HeroesSnapshot_{Game Version}_{Folder Name}_Data`: [Data only files](https://github.com/jamiephan/HeroesOfTheStorm_Gamedata#files)

### HeroesSnapshotGenerator_Data

Extract game data files and only output to the folder:
 - `HeroesSnapshot_{Game Version}_{Folder Name}_Data`: [Data only files](https://github.com/jamiephan/HeroesOfTheStorm_Gamedata#files)
