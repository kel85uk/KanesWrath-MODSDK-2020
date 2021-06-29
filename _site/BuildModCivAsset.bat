@echo off
@echo Mod Name: %1
@echo Building Mod Data...
tools\binaryAssetBuilder.exe "%cd%\Mods\%1\data\mod.xml" /od:"%cd%\BuiltMods" /iod:"%cd%\BuiltMods" /ls:true /gui:false /UsePrecompiled:true /vf:true
@echo Building Low LOD...
tools\binaryAssetBuilder.exe "%cd%\Mods\%1\data\mod.xml" /od:"%cd%\BuiltMods" /iod:"%cd%\BuiltMods" /ls:true /gui:false /UsePrecompiled:true /vf:true /bcn:LowLOD /bps:"%cd%\BuiltMods\mods\%1\data\mod.manifest"
@echo Copying str file if it exists...
IF EXIST "%cd%\Mods\%1\data\mod.str" copy "%cd%\Mods\%1\data\mod.str" "%cd%\BuiltMods\mods\%1\data"
@echo Copying Shaders...
IF NOT EXIST "%cd%\BuiltMods\mods\%1\Shaders" md "%cd%\BuiltMods\mods\%1\Shaders"
copy "%cd%\Shaders\*.fx" "%cd%\BuiltMods\mods\%1\Shaders"
del "%cd%\Builtmods\mods\%1\data\mod_l.version"
@echo Running Asset Resolver...
tools\AssetResolver.exe -m "%cd%\BuiltMods\mods\%1\data\mod.manifest" -s mod
@echo Creating Mod Big File...
tools\MakeBig.exe -f "%cd%\BuiltMods\mods\%1" -x:*.asset -o:"%cd%\BuiltMods\mods\%1.big"
@echo Copying built mod...
IF NOT EXIST "C:\Users\Jenkins\Documents\Command & Conquer 3 Tiberium Wars\mods" md "C:\Users\Jenkins\Documents\Command & Conquer 3 Tiberium Wars\mods
IF NOT EXIST "C:\Users\Jenkins\Documents\Command & Conquer 3 Tiberium Wars\mods\%1" md "C:\Users\Jenkins\Documents\Command & Conquer 3 Tiberium Wars\mods\%1
copy "builtmods\mods\%1.big" "C:\Users\Jenkins\Documents\Command & Conquer 3 Tiberium Wars\mods\%1"