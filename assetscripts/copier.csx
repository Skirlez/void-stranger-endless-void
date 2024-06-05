using UndertaleModLib.Models;
using UndertaleModLib.Util;
using UndertaleModLib.Decompiler;
using System.Linq;
using System.Text.Json;
using System.IO;


EnsureDataLoaded();

// Replace with your own
string endlessVoidPath = "C:/Users/David/Documents/GameMakerStudio2/void-stranger-endless-void";

// A script to copy all required Void Stranger assets into Endless Void.

// Scripts used for reference:
// ExportAllSounds.csx

// These functions are shamelessly stolen from that script.
Dictionary<string, IList<UndertaleEmbeddedAudio>> loadedAudioGroups;
IList<UndertaleEmbeddedAudio> GetAudioGroupData(UndertaleSound sound) {
    if (loadedAudioGroups == null)
        loadedAudioGroups = new Dictionary<string, IList<UndertaleEmbeddedAudio>>();

    string audioGroupName = sound.AudioGroup != null ? sound.AudioGroup.Name.Content : "audiogroup_default";
    if (loadedAudioGroups.ContainsKey(audioGroupName))
        return loadedAudioGroups[audioGroupName];

    string groupFilePath = $"{Path.GetDirectoryName(FilePath)}/audiogroup{sound.GroupID}.dat";
    if (!File.Exists(groupFilePath))
        return null; 

    try {
        UndertaleData data = null;
        using (var stream = new FileStream(groupFilePath, FileMode.Open, FileAccess.Read))
            data = UndertaleIO.Read(stream, warning => ScriptMessage("A warning occured while trying to load " + audioGroupName + ":\n" + warning));

        loadedAudioGroups[audioGroupName] = data.EmbeddedAudio;
        return data.EmbeddedAudio;
    } 
    catch (Exception e) {
        ScriptMessage("An error occured while trying to load " + audioGroupName + ":\n" + e.Message);
        return null;
    }
}
byte[] GetSoundData(UndertaleSound sound) {
    if (sound.AudioFile != null)
        return sound.AudioFile.Data;

    if (sound.GroupID > Data.GetBuiltinSoundGroupID()) {
        IList<UndertaleEmbeddedAudio> audioGroup = GetAudioGroupData(sound);
        if (audioGroup != null)
            return audioGroup[sound.AudioID].Data;
    }
    return null;
}


TextureWorker worker = new TextureWorker();

string[] getAssetNames(string path) {
    string[] assetPaths = Directory.GetDirectories(path);
    string[] assets = new string[assetPaths.Length];
    for (int i = 0; i < assetPaths.Length; i++)
        assets[i] = Path.GetFileName(assetPaths[i]);
    return assets;
}

void exportSpriteTexture(UndertaleTexturePageItem texture, string spriteDir, string name, string layerName) {
    worker.ExportAsPNG(texture, $"{spriteDir}/{name}.png", null, true);
    System.IO.Directory.CreateDirectory($"{spriteDir}/layers/{name}/");

    worker.ExportAsPNG(texture, $"{spriteDir}/layers/{name}/{layerName}.png", null, true);

}

string[] tilesetSprites = {"spr_tile_bg_1", "spr_tile_edges", "spr_tile_bg_void", "spr_tile_edges_true", "spr_tile_bg_secret", "spr_tile_bg_true"};
string[] sprites = getAssetNames(endlessVoidPath + "/sprites");
foreach (string spriteName in sprites) {
    UndertaleSprite sprite = Data.Sprites.ByName(spriteName);
    if (sprite is null && !tilesetSprites.Contains(spriteName))
        continue;

    string spriteDir = $"{endlessVoidPath}/sprites/{spriteName}";
    string yy = File.ReadAllText($"{spriteDir}/{spriteName}.yy");
    JsonDocument json = JsonDocument.Parse(yy, new JsonDocumentOptions { AllowTrailingCommas = true });
    JsonElement frames = json.RootElement.GetProperty("frames");
    JsonElement layers = json.RootElement.GetProperty("layers");
    if (layers.GetArrayLength() != 1) {
        ScriptMessage(spriteName + " has more than one layer, not copying.");
        continue;
    }
    string layerName = layers[0].GetProperty("name").GetString();

    if (tilesetSprites.Contains(spriteName)) {
        UndertaleBackground tileset = Data.Backgrounds.ByName(spriteName.Substring(4));
        string name = frames[0].GetProperty("name").GetString();
        exportSpriteTexture(tileset.Texture, spriteDir, name, layerName);
        continue;
    }

    for (int i = 0; i < frames.GetArrayLength(); i++) {
        string name = frames[i].GetProperty("name").GetString();
        exportSpriteTexture(sprite.Textures[i].Texture, spriteDir, name, layerName);
    }
}

string[] sounds = getAssetNames(endlessVoidPath + "/sounds");
foreach (string soundName in sounds) {
    UndertaleSound sound = Data.Sounds.ByName(soundName);
    if (sound is null)
        continue;
    byte[] bytes = GetSoundData(sound);
    if (bytes is not null)
        File.WriteAllBytes($"{endlessVoidPath}/sounds/{soundName}/{soundName}.wav", bytes);
}

ScriptMessage("Void Stranger assets now in place.");
