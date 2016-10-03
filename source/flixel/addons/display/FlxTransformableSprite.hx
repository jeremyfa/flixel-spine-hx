package flixel.addons.display;

import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.graphics.frames.FlxFrame.FlxFrameAngle;

import openfl.geom.Matrix;

class FlxTransformableSprite extends FlxSprite {

    public var transformMatrix:Matrix;

    /**
     * WARNING: This will remove this sprite entirely. Use kill() if you
     * want to disable it temporarily only and reset() it later to revive it.
     * Used to clean up memory.
     */
    override public function destroy():Void
    {
        super.destroy();

    } // destroy

    override function drawComplex(camera:FlxCamera):Void
    {
        _frame.prepareMatrix(_matrix, FlxFrameAngle.ANGLE_0, checkFlipX(), checkFlipY());
        _matrix.translate(-origin.x, -origin.y);
        _matrix.scale(scale.x, scale.y);

        if (bakedRotationAngle <= 0)
        {
            updateTrig();

            if (angle != 0) {
                _matrix.rotateWithTrig(_cosAngle, _sinAngle);
            }
        }
        _point.addPoint(origin);
        //if (isPixelPerfectRender(camera))
        //    _point.floor();

        _matrix.translate(_point.x, _point.y);

        if (transformMatrix != null) {
            _matrix.concat(transformMatrix);
        }

        camera.drawPixels(_frame, framePixels, _matrix, colorTransform, blend, antialiasing);

    } //drawComplex

    override public function isSimpleRender(?camera:FlxCamera):Bool
    {
        if (FlxG.renderBlit) {
            return super.isSimpleRender(camera) && transformMatrix == null;
        }
        else {
            return false;
        }

    } //isSimpleRender

    override public function isOnScreen(?Camera:FlxCamera):Bool {

        // TODO maybe make it smarter?
        return visible;

    } //isOnScreen

} //FlxTransformableSprite
