package flixel.addons.editors.spine.texture;

import openfl.Assets;
import openfl.display.BitmapData;
import spine.atlas.AtlasPage;
import spine.atlas.AtlasRegion;
import spine.atlas.TextureLoader;

class FlixelTextureLoader implements TextureLoader
{
	private var path:String;

	public function new(path:String)
	{
		this.path = path;
	}

	public function loadPage(page:AtlasPage, path:String):Void
	{
		var bitmapData:BitmapData = Assets.getBitmapData(this.path + path);
		if (bitmapData == null)
			throw ("BitmapData not found with name: " + this.path + path);
		page.rendererObject = bitmapData;
		page.width = bitmapData.width;
		page.height = bitmapData.height;
	}

	public function loadRegion(region:AtlasRegion):Void {  }

	public function unloadPage(page:AtlasPage):Void
	{
		cast(page.rendererObject, BitmapData).dispose();
	}
}
