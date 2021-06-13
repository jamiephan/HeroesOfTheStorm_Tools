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

## Is this tool perfect?

No. because it only search through all the existing in-game xml files, so the XSD generated will based on those files. If Blizzard did not use certain XML attributes (but exists in game engine), this tool will not able to find those.

Also this tool is mainly for my personal uses so it might not work for you.

## How to use it?

1. Make sure you have the following requirements installed:

 - WSL (Windows Subsystem on Linux)
 - Java (installed on Windows, not in WSL) and should be in `%PATH%` (e.g, running `where java` in cmd should shows path of java)

2. Extract all the game files with [CASCView](http://www.zezula.net/en/casc/main.html)

3. Copy both `schemaGenerator.sh` and `trang.jar` in the extracted folder:

```
CASCOutput/
    ├── mods/
    ├── schemaGenerator.sh
    └── trang.jar
```

4. In WSL, on the folder, run the following command:

```bash
chmod +x schemaGenerator.sh
./schemaGenerator.sh
```

5. Wait for a while and a XSD file should be generated.

