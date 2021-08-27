# HeroesOfTheStorm_XSDGenerator
Generate an XSD (XML Schema Definition) file from Heroes of the Storm XML files

## What is XSD?
XSD, XML Schema Definition is a file that describe and validate how a XML file should look like.

## Why?
Heroes of the Storm uses a modified Starcraft II engine, where some XML properties have been add/deleted.

For example:

- Removed SC2 Catalog: `<CAbilHarvest />`
- Added Heroes Catalog: `<CAbilRedirectInstant />`

This tool will search through all the XML files and generate a XDS file base on those XML files, which you can see what are the available XML keys. 

## What can I do with the XSD File?

- [Editor Auto-Completion](https://jamiephan.github.io/HeroesOfTheStorm_TryMode2.0/modding.html#mod-xml)
- XML Validation

## Is this tool perfect?

No. because it only search through all the existing in-game xml files, so the XSD generated will based on those files. If Blizzard did not use certain XML attributes (but exists in game engine), this tool will not able to find those.

Also this tool is mainly for my personal uses so it might not work for you.

## How to generate XSD?

1. Make sure you have the following requirements installed:

 - Java

>Note: If you have Java installed on your Windows and having WSL (WSL does not have java), please use the `schemaGenerator_WSL.sh` file instead, and of course change the commands below from `schemaGenerator.sh` to `schemaGenerator_WSL.sh`.

2. Extract all the game files with [CASCView](http://www.zezula.net/en/casc/main.html), or optionally you can use the [HeroesOfTheStorm_Gamedata](https://github.com/jamiephan/HeroesOfTheStorm_Gamedata), however the `xsd` file where already generated.

3. Copy both `schemaGenerator.sh` and `trang.jar` in the extracted folder:

```
CASCOutput/
    ├── mods/
    ├── schemaGenerator.sh
    └── trang.jar
```

4. In terminal (or WSL), at the extracted folder, run the following command:

```bash
chmod +x schemaGenerator.sh
./schemaGenerator.sh
```

5. Wait for a while and a XSD file should be generated.

