using UndertaleModLib.Models;
using UndertaleModLib.Util;
using UndertaleModLib.Decompiler;
using System.Linq;

// A script to clean Endless Void of any Void Stranger assets.

EnsureDataLoaded();

// Replace with your own
string endlessVoidPath = "C:/Users/David/Documents/GameMakerStudio2/void-stranger-endless-void";

string[] getAssetNames(string path) {
    string[] assetPaths = Directory.GetDirectories(path);
    string[] assets = new string[assetPaths.Length];
    for (int i = 0; i < assetPaths.Length; i++)
        assets[i] = Path.GetFileName(assetPaths[i]);
    return assets;
}

string[] sprites = getAssetNames(endlessVoidPath + "/sprites");
string[] tilesetSprites = {"spr_tile_bg_1", "spr_tile_edges"};
foreach (string spriteName in sprites) {
    if (Data.Sprites.ByName(spriteName) is null && !tilesetSprites.Contains(spriteName))
        continue;
    string[] files = Directory.GetFiles($"{endlessVoidPath}/sprites/{spriteName}/", "*.png");
    foreach (string image in files) {
        File.Delete(image);
        string imageName = Path.GetFileNameWithoutExtension(image);
        string[] layerFiles = Directory.GetFiles($"{endlessVoidPath}/sprites/{spriteName}/layers/{imageName}", "*.png");
        if (layerFiles.Length > 1) {
            ScriptMessage($"More than one layer file for {spriteName}, image {imageName}! Sort this immediately!");
            continue;
        }
        File.Delete(layerFiles[0]);
    }
}

string[] tilesets = getAssetNames(endlessVoidPath + "/tilesets");
foreach (string tilesetName in tilesets) {
    UndertaleBackground tileset = Data.Backgrounds.ByName(tilesetName);
    if (tileset is null)
        continue;
    File.Delete($"{endlessVoidPath}/tilesets/{tilesetName}/output_tileset.png");
}


string[] sounds = getAssetNames(endlessVoidPath + "/sounds");
foreach (string soundName in sounds) {
    if (Data.Sounds.ByName(soundName) is null)
        continue;
    string[] files = Directory.GetFiles($"{endlessVoidPath}/sounds/{soundName}/", "*.wav");
    foreach (string sound in files)
        File.Delete(sound);
}


ScriptMessage("Repository cleaned of all Void Stranger assets.");
