module tilengine

#flag -I @VMODROOT/includes
#include "Tilengine.h"

#flag -L @VMODROOT/lib
#flag -lTilengine

// [flag]
pub enum TileFlags {
	flag_none 		= 0			/*!< no flags */
	flag_flipx		= (1 << 15)	/*!< horizontal flip */
	flag_flipy		= (1 << 14)	/*!< vertical flip */
	flag_rotate		= (1 << 13)	/*!< row/column flip (unsupported, Tiled compatibility) */
	flag_priority	= (1 << 12)	/*!< tile goes in front of sprite layer */
	flag_masked		= (1 << 11)	/*!< sprite won't be drawn inside masked region */
	flag_tileset    = (7 << 8)		/*!< tileset index (0 - 7) */
	flag_palette	= (7 << 5)
}

pub enum Blend {
	blend_none		/*!< blending disabled */
	blend_mix25		/*!< color averaging 1 */
	blend_mix50		/*!< color averaging 2 */
	blend_mix75		/*!< color averaging 3 */
	blend_add		/*!< color is always brighter (simulate light effects) */
	blend_sub		/*!< color is always darker (simulate shadow effects) */
	blend_mod		/*!< color is always darker (simulate shadow effects) */
	blend_custom	/*!< user provided blend function with TLN_SetCustomBlendFunction() */
	max_blend
	// blend_mix = 2
}

pub enum LayerType {
	layer_none		/*!< undefined */
	layer_tile		/*!< tilemap-based layer */
	layer_object	/*!< objects layer */
	layer_bitmap	/*!< bitmapped layer */
}

[typedef]
struct C.TLN_Affine {
	pub mut:
		angle f32
		dx f32
		dy f32
		sx f32
		sy f32
}
pub type Affine = C.TLN_Affine

[typedef]
union C.Tile{}
pub type Tile = C.Tile

[typedef]
struct C.TLN_SequenceFrame {
	pub mut:
		index i32
		delay i32
}
pub type SequenceFrame = C.TLN_SequenceFrame

[typedef]
struct C.TLN_ColorStrip {
	pub mut:
		delay i32
		first u8
		count u8
		dir u8
}
pub type ColorStrip = C.TLN_ColorStrip

[typedef]
struct C.TLN_SequenceInfo {
	pub mut:
		name[32] char
		num_frames i32
}
pub type SequenceInfo = C.TLN_SequenceInfo

[typedef]
struct C.TLN_SpriteData {
	pub mut:
		name[64] char
		x i32
		y i32
		w i32
		h i32
}
pub type SpriteData = C.TLN_SpriteData

[typedef]
struct C.TLN_SpriteInfo {
	pub mut:
		w int
		h int
}
pub type SpriteInfo = C.TLN_SpriteInfo

[typedef]
struct C.TLN_TileInfo {
	pub mut:
		index u16
		flags u16
		row i32
		col i32
		xoffset i32
		yoffset i32
		color u8
		ttype u8
		empty bool
}
pub type TileInfo = C.TLN_TileInfo

[typedef]
struct C.TLN_ObjectInfo {
	pub mut:
		id u16
		gid u16
		flags u16
		x i32
		y i32
		width i32
		height i32
		otype u8
		visible bool
		name[64] char
}
pub type ObjectInfo = C.TLN_ObjectInfo

[typedef]
struct C.TLN_TileAttributes {
	pub mut:
		ttype u8
		priority bool
}
pub type TileAttributes = C.TLN_TileAttributes

pub enum CRT {
	tln_crt_slot
	tln_crt_aperture
	tln_crt_shadow
}

[typedef]
pub struct C.TLN_PixelMap {
	pub mut:
		dx i16
		dy i16
}
pub type PixelMap = C.TLN_PixelMap

[typedef]
struct C.TLN_Engine {}
pub type Engine = &C.TLN_Engine

[typedef]
struct C.TLN_Tileset {}
pub type Tileset = &C.TLN_Tileset

[typedef]
struct C.TLN_Tilemap {}
pub type Tilemap = &C.TLN_Tilemap

[typedef]
struct C.TLN_Palette {}
pub type Palette = &C.TLN_Palette

[typedef]
struct C.TLN_Spriteset {}
pub type SpriteSet = &C.TLN_Spriteset

[typedef]
struct C.TLN_Sequence {}
pub type Sequence = &C.TLN_Sequence

[typedef]
struct C.TLN_SequencePack {}
pub type SequencePack = &C.TLN_SequencePack

[typedef]
struct C.TLN_Bitmap {}
pub type Bitmap = &C.TLN_Bitmap

[typedef]
struct C.TLN_ObjectList {}
pub type ObjectList = &C.TLN_ObjectList

[typedef]
struct C.TLN_Tile {}
pub type TTile = &C.TLN_Tile

[typedef]
struct C.TLN_TileImage {
	pub mut:
		bitmap Bitmap
		id     u16
		ttype  u8
}
pub type TileImage = C.TLN_TileImage

[typedef]
struct C.TLN_SpriteState {
	pub mut:
		x         int
		y         int
		w         int
		h         int
		flags     u32
		palette   Palette
		spriteset SpriteSet
		index     int
		enabled   bool
		collision bool
}
pub type SpriteState = C.TLN_SpriteState

type TLN_VideoCallback = fn (int)
pub type VideoCallback = fn (int)

type TLN_BlendFunction = fn (u8, u8) u8
pub type BlendFunction = fn (u8, u8) u8

// pub type TLN_SDLCallback = fn (&SDL_Event)

pub enum Player {
	player1
	player2
	player3
	player4
}

pub enum Input {
	input_none
	input_up
	input_down
	input_left
	input_right
	input_button1
	input_button2
	input_button3
	input_button4
	input_button5
	input_button6
	input_start
	input_quit
	input_crt
	input_p1 = 0 << 5
	input_p2 = 1 << 5
	input_p3 = 2 << 5
	input_p4 = 3 << 5
}

pub enum WindowFlags {
	cwf_fullscreen	= (1 << 0)	/*!<1 create a fullscreen window */
	cwf_vsync		= (1 << 1)	/*!<2 sync frame updates with vertical retrace */
	cwf_s1			= (1 << 2)	/*!<4 create a window the same size as the framebuffer */
	cwf_s2			= (2 << 2)	/*!<8 create a window 2x the size the framebuffer */
	cwf_s3			= (3 << 2)	/*!<12 create a window 3x the size the framebuffer */
	cwf_s4			= (4 << 2)	/*!<16 create a window 4x the size the framebuffer */
	cwf_s5			= (5 << 2)	/*!<20 create a window 5x the size the framebuffer */
	cwf_nearest		= (1 << 6)	/*<!64 unfiltered upscaling */
}

[typedef]
enum TLN_Error {
	tln_err_ok
	tln_err_out_of_memory
	tln_err_idx_layer
	tln_err_idx_sprite
	tln_err_idx_animation
	tln_err_idx_picture
	tln_err_ref_tileset
	tln_err_ref_tilemap
	tln_err_ref_spriteset
	tln_err_ref_palette
	tln_err_ref_sequence
	tln_err_ref_seqpack
	tln_err_ref_bitmap
	tln_err_null_pointer
	tln_err_file_not_found
	tln_err_wrong_format
	tln_err_wrong_size
	tln_err_unsupported
	tln_err_ref_list
	tln_err_idx_palette
	tln_max_err
}
pub type EngineError = TLN_Error

pub enum LogLevel {
	tln_log_none
	tln_log_errors
	tln_log_verbose
}




fn C.TLN_Init(hres int, vres int, numlayers int, numsprites int, numanimations int) Engine
pub fn init(hres int, vres int, numlayers int, numsprites int, numanimations int) Engine {
	return C.TLN_Init(hres, vres, numlayers, numsprites, numanimations)
}

fn C.TLN_Deinit()
pub fn deinit() {
	C.TLN_Deinit()
}

fn C.TLN_DeleteContext(context &C.TLN_Engine) bool
pub fn deletecontext(context Engine) bool {
	return C.TLN_DeleteContext(context)
}

fn C.TLN_SetContext(context &C.TLN_Engine) bool
pub fn setcontext(context Engine) bool {
	return C.TLN_SetContext(context)
}

fn C.TLN_GetContext() Engine
pub fn getcontext() Engine {
	return C.TLN_GetContext()
}

fn C.TLN_GetWidth() int
pub fn getwidth() int {
	return C.TLN_GetWidth()
}

fn C.TLN_GetHeight() int
pub fn getheight() int {
	return C.TLN_GetHeight()
}

fn C.TLN_GetNumObjects() u32
pub fn getnumobjects() u32 {
	return C.TLN_GetNumObjects()
}

fn C.TLN_GetUsedMemory() u32
pub fn getusedmemory() u32 {
	return C.TLN_GetUsedMemory()
}

fn C.TLN_GetVersion() u32
pub fn getversion() u32 {
	return C.TLN_GetVersion()
}

fn C.TLN_GetNumLayers() int
pub fn getnumlayers() int {
	return C.TLN_GetNumLayers()
}

fn C.TLN_GetNumSprites() int
pub fn getnumsprites() int {
	return C.TLN_GetNumSprites()
}

fn C.TLN_SetBGColor(r u8, g u8, b u8)
pub fn setbgcolor(r u8, g u8, b u8) {
	C.TLN_SetBGColor(r, g, b)
}

fn C.TLN_SetBGColorFromTilemap(tilemap &C.TLN_Tilemap) bool
pub fn setbgcolorfromtilemap(tilemap Tilemap) bool {
	return C.TLN_SetBGColorFromTilemap(tilemap)
}

fn C.TLN_DisableBGColor()
pub fn disablebgcolor() {
	C.TLN_DisableBGColor()
}

fn C.TLN_SetBGBitmap(bitmap &C.TLN_Bitmap) bool
pub fn setbgbitmap(bitmap Bitmap) bool {
	return C.TLN_SetBGBitmap(bitmap)
}

fn C.TLN_SetBGPalette(palette &C.TLN_Palette) bool
pub fn tln_setbgpalette(palette Palette) bool {
	return C.TLN_SetBGPalette(palette)
}

pub fn C.TLN_SetGlobalPalette(index int, palette Palette) bool
pub fn setglobalpalette(index int, palette Palette) bool {
	return C.TLN_SetGlobalPalette(index, Palette(palette))
}

fn C.TLN_SetRasterCallback(callback TLN_VideoCallback)
pub fn setrastercallback(callback TLN_VideoCallback) {
	C.TLN_SetRasterCallback(callback)
}
fn C.TLN_SetFrameCallback(callback TLN_VideoCallback)
pub fn setframecallback(callback TLN_VideoCallback) {
	C.TLN_SetFrameCallback(callback)
}

fn C.TLN_SetRenderTarget(data &u8, pitch int)
pub fn setrendertarget(data[] u8, pitch int) {
	C.TLN_SetRenderTarget(&u8(data[0]), pitch)
}

fn C.TLN_UpdateFrame(frame int)
pub fn updateframe(frame int) {
	C.TLN_UpdateFrame(frame)
}

fn C.TLN_SetLoadPath(path &i8)
pub fn setloadpath(path string) {
	C.TLN_SetLoadPath(path.str)
}

fn C.TLN_SetCustomBlendFunction(blendFunc TLN_BlendFunction)
pub fn setcustomblendfunction(blendFunc TLN_BlendFunction) {
	C.TLN_SetCustomBlendFunction(blendFunc)
}

fn C.TLN_SetLogLevel(log_level LogLevel)
pub fn setloglevel(log_level LogLevel) {
	C.TLN_SetLogLevel(log_level)
}

fn C.TLN_OpenResourcePack(filename &i8, key &i8) bool
pub fn openresourcepack(filename string, key string) bool {
	return C.TLN_OpenResourcePack(filename.str, key.str)
}

fn C.TLN_CloseResourcePack()
pub fn closeresourcepack() {
	C.TLN_CloseResourcePack()
}

pub fn C.TLN_GetGlobalPalette(index int) Palette
pub fn getglobalpalette(index int) Palette {
	return C.TLN_GetGlobalPalette(index)
}

fn C.TLN_SetLastError(error TLN_Error)
pub fn setlasterror(error EngineError) {
	C.TLN_SetLastError(error)
}

fn C.TLN_GetLastError() TLN_Error
pub fn getlasterror() EngineError {
	return C.TLN_GetLastError()
}

fn C.TLN_GetErrorString(error TLN_Error) &i8
pub fn geterrorstring(error EngineError) string {
	return unsafe {cstring_to_vstring(&char(C.TLN_GetErrorString(error)))}
}

fn C.TLN_CreateWindow(overlay &char, flags int) bool
pub fn createwindow(overlay string, flags []WindowFlags) bool {
	mut f := 0
	for i in flags {
		f |= int(i)
	}
	return C.TLN_CreateWindow(overlay.str, f)
}

fn C.TLN_CreateWindowThread(overlay &char, flags int) bool
pub fn createwindowthread(overlay string, flags int) bool {
	return C.TLN_CreateWindowThread(overlay.str, flags)
}

fn C.TLN_SetWindowTitle(title &char)
pub fn setwindowtitle(title string) {
	C.TLN_SetWindowTitle(title.str)
}

fn C.TLN_ProcessWindow() bool
pub fn processwindow() bool {
	return C.TLN_ProcessWindow()
}

fn C.TLN_IsWindowActive() bool
pub fn iswindowactive() bool {
	return C.TLN_IsWindowActive()
}

fn C.TLN_GetInput(id Input) bool
pub fn getinput(id Input) bool {
	return C.TLN_GetInput(id)
}

fn C.TLN_EnableInput(player Player, enable bool)
pub fn enableinput(player Player, enable bool) {
	C.TLN_EnableInput(player, enable)
}

fn C.TLN_AssignInputJoystick(player Player, index int)
pub fn assigninputjoystick(player Player, index int) {
	C.TLN_AssignInputJoystick(player, index)
}

fn C.TLN_DefineInputKey(player Player, input Input, keycode u32)

pub fn defineinputkey(player Player, input Input, keycode u32) {
	C.TLN_DefineInputKey(player, input, keycode)
}

fn C.TLN_DefineInputButton(player Player, input Input, joybutton u8)

pub fn defineinputbutton(player Player, input Input, joybutton u8) {
	C.TLN_DefineInputButton(player, input, joybutton)
}

fn C.TLN_DrawFrame(frame int)
pub fn drawframe(frame int) {
	C.TLN_DrawFrame(frame)
}

fn C.TLN_WaitRedraw()
pub fn waitredraw() {
	C.TLN_WaitRedraw()
}

fn C.TLN_DeleteWindow()
pub fn deletewindow() {
	C.TLN_DeleteWindow()
}

fn C.TLN_EnableBlur(mode bool)
pub fn enableblur(mode bool) {
	C.TLN_EnableBlur(mode)
}

fn C.TLN_ConfigCRTEffect(type_ CRT, blur bool)
pub fn configcrteffect(type_ CRT, blur bool) {
	C.TLN_ConfigCRTEffect(type_, blur)
}

fn C.TLN_EnableCRTEffect(overlay int, overlay_factor u8, threshold u8, v0 u8, v1 u8, v2 u8, v3 u8, blur bool, glow_factor u8)
pub fn enablecrteffect(overlay int, overlay_factor u8, threshold u8, v0 u8, v1 u8, v2 u8, v3 u8, blur bool, glow_factor u8) {
	C.TLN_EnableCRTEffect(overlay, overlay_factor, threshold, v0, v1, v2, v3, blur, glow_factor)
}

fn C.TLN_DisableCRTEffect()
pub fn disablecrteffect() {
	C.TLN_DisableCRTEffect()
}

// fn C.TLN_SetSDLCallback(callback TLN_SDLCallback)
//
// pub fn tln_setsdlcallback(callback TLN_SDLCallback) {
// 	C.TLN_SetSDLCallback(callback)
// }

fn C.TLN_Delay(msecs u32)
pub fn delay(msecs u32) {
	C.TLN_Delay(msecs)
}

fn C.TLN_GetTicks() u32
pub fn getticks() u32 {
	return C.TLN_GetTicks()
}

fn C.TLN_GetWindowWidth() int
pub fn getwindowwidth() int {
	return C.TLN_GetWindowWidth()
}

fn C.TLN_GetWindowHeight() int
pub fn getwindowheight() int {
	return C.TLN_GetWindowHeight()
}

fn C.TLN_CreateSpriteset(bitmap Bitmap, data &C.TLN_SpriteData, num_entries int) SpriteSet
pub fn createspriteset(bitmap Bitmap, data &SpriteData, num_entries int) SpriteSet {
	return C.TLN_CreateSpriteset(bitmap, data, num_entries)
}

fn C.TLN_LoadSpriteset(name &char) SpriteSet
pub fn loadspriteset(name string) SpriteSet {
	return C.TLN_LoadSpriteset(name.str)
}

fn C.TLN_CloneSpriteset(src SpriteSet) SpriteSet
pub fn clonespriteset(src SpriteSet) SpriteSet {
	return C.TLN_CloneSpriteset(src)
}

fn C.TLN_GetSpriteInfo(spriteset &C.TLN_Spriteset, entry int, info &C.TLN_SpriteInfo) bool
pub fn getspriteinfo(spriteset SpriteSet, entry int, info &SpriteInfo) bool {
	return C.TLN_GetSpriteInfo(spriteset, entry, info)
}

fn C.TLN_GetSpritesetPalette(spriteset &C.TLN_Spriteset) Palette
pub fn getspritesetpalette(spriteset SpriteSet) Palette {
	return C.TLN_GetSpritesetPalette(spriteset)
}

fn C.TLN_FindSpritesetSprite(spriteset &C.TLN_Spriteset, name &char) int
pub fn findspritesetsprite(spriteset SpriteSet, name string) int {
	return C.TLN_FindSpritesetSprite(spriteset, name.str)
}

fn C.TLN_SetSpritesetData(spriteset &C.TLN_Spriteset, entry int, data &C.TLN_SpriteData, pixels voidptr, pitch int) bool
pub fn setspritesetdata(spriteset SpriteSet, entry int, data &SpriteData, pixels voidptr, pitch int) bool {
	return C.TLN_SetSpritesetData(spriteset, entry, data, pixels, pitch)
}

fn C.TLN_DeleteSpriteset(spriteset &C.TLN_Spriteset) bool
pub fn deletespriteset(spriteset SpriteSet) bool {
	return C.TLN_DeleteSpriteset(spriteset)
}

fn C.TLN_CreateTileset(numtiles int, width int, height int, palette &C.TLN_Palette, sp &C.TLN_SequencePack, attributes &C.TLN_TileAttributes) Tileset
pub fn createtileset(numtiles int, width int, height int, palette Palette, sp SequencePack, attributes &TileAttributes) Tileset {
	return C.TLN_CreateTileset(numtiles, width, height, palette, sp, attributes)
}

fn C.TLN_CreateImageTileset(numtiles int, images &C.TLN_TileImage) Tileset
pub fn createimagetileset(numtiles int, images &TileImage) Tileset {
	return C.TLN_CreateImageTileset(numtiles, images)
}

fn C.TLN_LoadTileset(filename &char) Tileset
pub fn loadtileset(filename string) Tileset {
	return C.TLN_LoadTileset(filename.str)
}

fn C.TLN_CloneTileset(src &C.TLN_Tileset) Tileset
pub fn clonetileset(src Tileset) Tileset {
	return C.TLN_CloneTileset(src)
}

fn C.TLN_SetTilesetPixels(tileset &C.TLN_Tileset, entry int, srcdata &u8, srcpitch int) bool
pub fn settilesetpixels(tileset Tileset, entry int, srcdata []u8, srcpitch int) bool {
	return C.TLN_SetTilesetPixels(tileset, entry, &u8(srcdata[0]), srcpitch)
}

fn C.TLN_GetTileWidth(tileset &C.TLN_Tileset) int
pub fn gettilewidth(tileset Tileset) int {
	return C.TLN_GetTileWidth(tileset)
}

fn C.TLN_GetTileHeight(tileset &C.TLN_Tileset) int
pub fn gettileheight(tileset Tileset) int {
	return C.TLN_GetTileHeight(tileset)
}

fn C.TLN_GetTilesetNumTiles(tileset &C.TLN_Tileset) int
pub fn gettilesetnumtiles(tileset Tileset) int {
	return C.TLN_GetTilesetNumTiles(tileset)
}

fn C.TLN_GetTilesetPalette(tileset &C.TLN_Tileset) Palette
pub fn gettilesetpalette(tileset &C.TLN_Tileset) Palette {
	return C.TLN_GetTilesetPalette(tileset)
}

fn C.TLN_GetTilesetSequencePack(tileset &C.TLN_Tileset) SequencePack
pub fn gettilesetsequencepack(tileset Tileset) SequencePack {
	return C.TLN_GetTilesetSequencePack(tileset)
}

fn C.TLN_DeleteTileset(tileset &C.TLN_Tileset) bool
pub fn deletetileset(tileset Tileset) bool {
	return C.TLN_DeleteTileset(tileset)
}

fn C.TLN_CreateTilemap(rows int, cols int, tiles &C.TLN_Tile, bgcolor u32, tileset &C.TLN_Tileset) Tilemap
pub fn createtilemap(rows int, cols int, tiles TTile, bgcolor u32, tileset Tileset) Tilemap {
	return C.TLN_CreateTilemap(rows, cols, tiles, bgcolor, tileset)
}

fn C.TLN_LoadTilemap(filename &char, layername &char) Tilemap
pub fn loadtilemap(filename string, layername string) Tilemap {
	if layername == "" {
		return C.TLN_LoadTilemap(filename.str, unsafe {nil})
	}
	return C.TLN_LoadTilemap(filename.str, layername.str)
}

fn C.TLN_CloneTilemap(src &C.TLN_Tilemap) Tilemap
pub fn clonetilemap(src Tilemap) Tilemap {
	return C.TLN_CloneTilemap(src)
}

fn C.TLN_GetTilemapRows(tilemap &C.TLN_Tilemap) int
pub fn gettilemaprows(tilemap Tilemap) int {
	return C.TLN_GetTilemapRows(tilemap)
}

fn C.TLN_GetTilemapCols(tilemap &C.TLN_Tilemap) int
pub fn gettilemapcols(tilemap Tilemap) int {
	return C.TLN_GetTilemapCols(tilemap)
}

fn C.TLN_SetTilemapTileset(tilemap &C.TLN_Tilemap, tileset &C.TLN_Tileset) bool
pub fn settilemaptileset(tilemap Tilemap, tileset Tileset) bool {
	return C.TLN_SetTilemapTileset(tilemap, tileset)
}

fn C.TLN_GetTilemapTileset(tilemap &C.TLN_Tilemap) Tileset
pub fn gettilemaptileset(tilemap Tilemap) Tileset {
	return C.TLN_GetTilemapTileset(tilemap)
}

fn C.TLN_SetTilemapTileset2(tilemap &C.TLN_Tilemap, tileset &C.TLN_Tileset, index int) bool
pub fn settilemaptileset2(tilemap Tilemap, tileset Tileset, index int) bool {
	return C.TLN_SetTilemapTileset2(tilemap, tileset, index)
}

fn C.TLN_GetTilemapTileset2(tilemap &C.TLN_Tilemap, index int) Tileset
pub fn gettilemaptileset2(tilemap Tilemap, index int) Tileset {
	return C.TLN_GetTilemapTileset2(tilemap, index)
}

fn C.TLN_GetTilemapTile(tilemap &C.TLN_Tilemap, row int, col int, tile &C.TLN_Tile) bool
pub fn gettilemaptile(tilemap Tilemap, row int, col int, tile TTile) bool {
	return C.TLN_GetTilemapTile(tilemap, row, col, tile)
}

fn C.TLN_SetTilemapTile(tilemap &C.TLN_Tilemap, row int, col int, tile &C.TLN_Tile) bool
pub fn settilemaptile(tilemap Tilemap, row int, col int, tile TTile) bool {
	return C.TLN_SetTilemapTile(tilemap, row, col, tile)
}

fn C.TLN_CopyTiles(src &C.TLN_Tilemap, srcrow int, srccol int, rows int, cols int, dst &C.TLN_Tilemap, dstrow int, dstcol int) bool
pub fn copytiles(src Tilemap, srcrow int, srccol int, rows int, cols int, dst Tilemap, dstrow int, dstcol int) bool {
	return C.TLN_CopyTiles(src, srcrow, srccol, rows, cols, dst, dstrow, dstcol)
}

pub fn C.TLN_GetTilemapTiles(tilemap &C.TLN_Tilemap, row int, col int) TTile
pub fn gettilemaptiles(tilemap Tilemap, row int, col int) TTile {
	return C.TLN_GetTilemapTiles(tilemap, row, col)
}

fn C.TLN_DeleteTilemap(tilemap &C.TLN_Tilemap) bool
pub fn deletetilemap(tilemap Tilemap) bool {
	return C.TLN_DeleteTilemap(tilemap)
}

fn C.TLN_CreatePalette(entries int) Palette
pub fn createpalette(entries int) Palette {
	return C.TLN_CreatePalette(entries)
}

fn C.TLN_LoadPalette(filename &char) Palette
pub fn loadpalette(filename string) Palette {
	return C.TLN_LoadPalette(filename.str)
}

fn C.TLN_ClonePalette(src &C.TLN_Palette) Palette
pub fn clonepalette(src Palette) Palette {
	return C.TLN_ClonePalette(src)
}

fn C.TLN_SetPaletteColor(palette &C.TLN_Palette, color int, r u8, g u8, b u8) bool
pub fn setpalettecolor(palette Palette, color int, r u8, g u8, b u8) bool {
	return C.TLN_SetPaletteColor(palette, color, r, g, b)
}

fn C.TLN_MixPalettes(src1 &C.TLN_Palette, src2 &C.TLN_Palette, dst &C.TLN_Palette, factor u8) bool
pub fn mixpalettes(src1 Palette, src2 Palette, dst Palette, factor u8) bool {
	return C.TLN_MixPalettes(src1, src2, dst, factor)
}

fn C.TLN_AddPaletteColor(palette &C.TLN_Palette, r u8, g u8, b u8, start u8, num u8) bool
pub fn addpalettecolor(palette Palette, r u8, g u8, b u8, start u8, num u8) bool {
	return C.TLN_AddPaletteColor(palette, r, g, b, start, num)
}

fn C.TLN_SubPaletteColor(palette &C.TLN_Palette, r u8, g u8, b u8, start u8, num u8) bool
pub fn subpalettecolor(palette Palette, r u8, g u8, b u8, start u8, num u8) bool {
	return C.TLN_SubPaletteColor(palette, r, g, b, start, num)
}

fn C.TLN_ModPaletteColor(palette &C.TLN_Palette, r u8, g u8, b u8, start u8, num u8) bool
pub fn modpalettecolor(palette Palette, r u8, g u8, b u8, start u8, num u8) bool {
	return C.TLN_ModPaletteColor(palette, r, g, b, start, num)
}

fn C.TLN_GetPaletteData(palette &C.TLN_Palette, index int) &u8
pub fn getpalettedata(palette Palette, index int) &u8 {
	return C.TLN_GetPaletteData(palette, index)
}

fn C.TLN_DeletePalette(palette &C.TLN_Palette) bool
pub fn deletepalette(palette Palette) bool {
	return C.TLN_DeletePalette(palette)
}

fn C.TLN_CreateBitmap(width int, height int, bpp int) Bitmap
pub fn createbitmap(width int, height int, bpp int) Bitmap {
	return C.TLN_CreateBitmap(width, height, bpp)
}

fn C.TLN_LoadBitmap(filename &char) Bitmap
pub fn loadbitmap(filename string) Bitmap {
	return C.TLN_LoadBitmap(filename.str)
}

fn C.TLN_CloneBitmap(src &C.TLN_Bitmap) Bitmap
pub fn tln_clonebitmap(src Bitmap) Bitmap {
	return C.TLN_CloneBitmap(src)
}

fn C.TLN_GetBitmapPtr(bitmap &C.TLN_Bitmap, x int, y int) &u8
pub fn getbitmapptr(bitmap Bitmap, x int, y int) &u8 {
	return C.TLN_GetBitmapPtr(bitmap, x, y)
}

fn C.TLN_GetBitmapWidth(bitmap &C.TLN_Bitmap) int
pub fn getbitmapwidth(bitmap Bitmap) int {
	return C.TLN_GetBitmapWidth(bitmap)
}

fn C.TLN_GetBitmapHeight(bitmap &C.TLN_Bitmap) int
pub fn getbitmapheight(bitmap Bitmap) int {
	return C.TLN_GetBitmapHeight(bitmap)
}

fn C.TLN_GetBitmapDepth(bitmap &C.TLN_Bitmap) int
pub fn getbitmapdepth(bitmap Bitmap) int {
	return C.TLN_GetBitmapDepth(bitmap)
}

fn C.TLN_GetBitmapPitch(bitmap &C.TLN_Bitmap) int
pub fn getbitmappitch(bitmap Bitmap) int {
	return C.TLN_GetBitmapPitch(bitmap)
}

fn C.TLN_GetBitmapPalette(bitmap &C.TLN_Bitmap) Palette
pub fn getbitmappalette(bitmap Bitmap) Palette {
	return C.TLN_GetBitmapPalette(bitmap)
}

fn C.TLN_SetBitmapPalette(bitmap &C.TLN_Bitmap, palette &C.TLN_Palette) bool
pub fn setbitmappalette(bitmap Bitmap, palette Palette) bool {
	return C.TLN_SetBitmapPalette(bitmap, palette)
}

fn C.TLN_DeleteBitmap(bitmap &C.TLN_Bitmap) bool
pub fn deletebitmap(bitmap Bitmap) bool {
	return C.TLN_DeleteBitmap(bitmap)
}

fn C.TLN_CreateObjectList() ObjectList
pub fn createobjectlist() ObjectList {
	return C.TLN_CreateObjectList()
}

fn C.TLN_AddTileObjectToList(list &C.TLN_ObjectList, id u16, gid u16, flags u16, x int, y int) bool
pub fn addtileobjecttolist(list ObjectList, id u16, gid u16, flags u16, x int, y int) bool {
	return C.TLN_AddTileObjectToList(list, id, gid, flags, x, y)
}

fn C.TLN_LoadObjectList(filename &char, layername &char) ObjectList
pub fn loadobjectlist(filename string, layername string) ObjectList {
	return C.TLN_LoadObjectList(filename.str, layername.str)
}

fn C.TLN_CloneObjectList(src &C.TLN_ObjectList) ObjectList
pub fn cloneobjectlist(src ObjectList) ObjectList {
	return C.TLN_CloneObjectList(src)
}

fn C.TLN_GetListNumObjects(list &C.TLN_ObjectList) int
pub fn getlistnumobjects(list ObjectList) int {
	return C.TLN_GetListNumObjects(list)
}

fn C.TLN_GetListObject(list &C.TLN_ObjectList, info &C.TLN_ObjectInfo) bool
pub fn getlistobject(list ObjectList, info &ObjectInfo) bool {
	return C.TLN_GetListObject(list, info)
}

fn C.TLN_DeleteObjectList(list &C.TLN_ObjectList) bool
pub fn deleteobjectlist(list ObjectList) bool {
	return C.TLN_DeleteObjectList(list)
}

fn C.TLN_SetLayer(nlayer int, tileset &C.TLN_Tileset, tilemap &C.TLN_Tilemap) bool
pub fn setlayer(nlayer int, tileset Tileset, tilemap Tilemap) bool {
	return C.TLN_SetLayer(nlayer, tileset, tilemap)
}

fn C.TLN_SetLayerTilemap(nlayer int, tilemap &C.TLN_Tilemap) bool

pub fn setlayertilemap(nlayer int, tilemap Tilemap) bool {
	return C.TLN_SetLayerTilemap(nlayer, tilemap)
}

fn C.TLN_SetLayerBitmap(nlayer int, bitmap &C.TLN_Bitmap) bool
pub fn setlayerbitmap(nlayer int, bitmap Bitmap) bool {
	return C.TLN_SetLayerBitmap(nlayer, bitmap)
}

fn C.TLN_SetLayerPalette(nlayer int, palette &C.TLN_Palette) bool
pub fn setlayerpalette(nlayer int, palette Palette) bool {
	return C.TLN_SetLayerPalette(nlayer, palette)
}

fn C.TLN_SetLayerPosition(nlayer int, hstart int, vstart int) bool
pub fn setlayerposition(nlayer int, hstart int, vstart int) bool {
	return C.TLN_SetLayerPosition(nlayer, hstart, vstart)
}

fn C.TLN_SetLayerScaling(nlayer int, xfactor f32, yfactor f32) bool
pub fn setlayerscaling(nlayer int, xfactor f32, yfactor f32) bool {
	return C.TLN_SetLayerScaling(nlayer, xfactor, yfactor)
}

fn C.TLN_SetLayerAffineTransform(nlayer int, affine &C.TLN_Affine) bool
pub fn setlayeraffinetransform(nlayer int, affine &Affine) bool {
	return C.TLN_SetLayerAffineTransform(nlayer, affine)
}

fn C.TLN_SetLayerTransform(layer int, angle f32, dx f32, dy f32, sx f32, sy f32) bool

pub fn setlayertransform(layer int, angle f32, dx f32, dy f32, sx f32, sy f32) bool {
	return C.TLN_SetLayerTransform(layer, angle, dx, dy, sx, sy)
}

fn C.TLN_SetLayerPixelMapping(nlayer int, table &C.TLN_PixelMap) bool
pub fn setlayerpixelmapping(nlayer int, table &PixelMap) bool {
	return C.TLN_SetLayerPixelMapping(nlayer, table)
}

fn C.TLN_SetLayerBlendMode(nlayer int, mode Blend, factor u8) bool
pub fn setlayerblendmode(nlayer int, mode Blend, factor u8) bool {
	return C.TLN_SetLayerBlendMode(nlayer, mode, factor)
}

fn C.TLN_SetLayerColumnOffset(nlayer int, offset &int) bool
pub fn setlayercolumnoffset(nlayer int, offset []int) bool {
	return C.TLN_SetLayerColumnOffset(nlayer, &int(offset[0]))
}

fn C.TLN_SetLayerClip(nlayer int, x1 int, y1 int, x2 int, y2 int) bool
pub fn setlayerclip(nlayer int, x1 int, y1 int, x2 int, y2 int) bool {
	return C.TLN_SetLayerClip(nlayer, x1, y1, x2, y2)
}

fn C.TLN_DisableLayerClip(nlayer int) bool
pub fn disablelayerclip(nlayer int) bool {
	return C.TLN_DisableLayerClip(nlayer)
}

fn C.TLN_SetLayerMosaic(nlayer int, width int, height int) bool
pub fn setlayermosaic(nlayer int, width int, height int) bool {
	return C.TLN_SetLayerMosaic(nlayer, width, height)
}

fn C.TLN_DisableLayerMosaic(nlayer int) bool
pub fn disablelayermosaic(nlayer int) bool {
	return C.TLN_DisableLayerMosaic(nlayer)
}

fn C.TLN_ResetLayerMode(nlayer int) bool
pub fn resetlayermode(nlayer int) bool {
	return C.TLN_ResetLayerMode(nlayer)
}

fn C.TLN_SetLayerObjects(nlayer int, objects &C.TLN_ObjectList, tileset &C.TLN_Tileset) bool
pub fn setlayerobjects(nlayer int, objects ObjectList, tileset Tileset) bool {
	return C.TLN_SetLayerObjects(nlayer, objects, tileset)
}

fn C.TLN_SetLayerPriority(nlayer int, enable bool) bool
pub fn setlayerpriority(nlayer int, enable bool) bool {
	return C.TLN_SetLayerPriority(nlayer, enable)
}

fn C.TLN_SetLayerParent(nlayer int, parent int) bool
pub fn setlayerparent(nlayer int, parent int) bool {
	return C.TLN_SetLayerParent(nlayer, parent)
}

fn C.TLN_DisableLayerParent(nlayer int) bool
pub fn disablelayerparent(nlayer int) bool {
	return C.TLN_DisableLayerParent(nlayer)
}

fn C.TLN_DisableLayer(nlayer int) bool
pub fn disablelayer(nlayer int) bool {
	return C.TLN_DisableLayer(nlayer)
}

fn C.TLN_EnableLayer(nlayer int) bool
pub fn enablelayer(nlayer int) bool {
	return C.TLN_EnableLayer(nlayer)
}

fn C.TLN_GetLayerType(nlayer int) LayerType
pub fn getlayertype(nlayer int) LayerType {
	return C.TLN_GetLayerType(nlayer)
}

fn C.TLN_GetLayerPalette(nlayer int) Palette

pub fn getlayerpalette(nlayer int) Palette {
	return C.TLN_GetLayerPalette(nlayer)
}

fn C.TLN_GetLayerTileset(nlayer int) Tileset
pub fn getlayertileset(nlayer int) Tileset {
	return C.TLN_GetLayerTileset(nlayer)
}

fn C.TLN_GetLayerTilemap(nlayer int) Tilemap
pub fn getlayertilemap(nlayer int) Tilemap {
	return C.TLN_GetLayerTilemap(nlayer)
}

fn C.TLN_GetLayerBitmap(nlayer int) Bitmap
pub fn getlayerbitmap(nlayer int) Bitmap {
	return C.TLN_GetLayerBitmap(nlayer)
}

fn C.TLN_GetLayerObjects(nlayer int) ObjectList
pub fn getlayerobjects(nlayer int) ObjectList {
	return C.TLN_GetLayerObjects(nlayer)
}

fn C.TLN_GetLayerTile(nlayer int, x int, y int, info &C.TLN_TileInfo) bool
pub fn getlayertile(nlayer int, x int, y int, info &TileInfo) bool {
	return C.TLN_GetLayerTile(nlayer, x, y, info)
}

fn C.TLN_GetLayerWidth(nlayer int) int
pub fn getlayerwidth(nlayer int) int {
	return C.TLN_GetLayerWidth(nlayer)
}

fn C.TLN_GetLayerHeight(nlayer int) int
pub fn getlayerheight(nlayer int) int {
	return C.TLN_GetLayerHeight(nlayer)
}

pub fn C.TLN_GetLayerX(nlayer int) int
pub fn getlayerx(nlayer int) int {
	return C.TLN_GetLayerX(nlayer)
}

pub fn C.TLN_GetLayerY(nlayer int) int
pub fn getlayery(nlayer int) int {
	return C.TLN_GetLayerY(nlayer)
}

fn C.TLN_ConfigSprite(nsprite int, spriteset &C.TLN_Spriteset, flags u32) bool
pub fn configsprite(nsprite int, spriteset SpriteSet, flags u32) bool {
	return C.TLN_ConfigSprite(nsprite, spriteset, flags)
}

fn C.TLN_SetSpriteSet(nsprite int, spriteset &C.TLN_Spriteset) bool
pub fn setspriteset(nsprite int, spriteset SpriteSet) bool {
	return C.TLN_SetSpriteSet(nsprite, spriteset)
}

fn C.TLN_SetSpriteFlags(nsprite int, flags u32) bool
pub fn setspriteflags(nsprite int, flags u32) bool {
	return C.TLN_SetSpriteFlags(nsprite, flags)
}

fn C.TLN_EnableSpriteFlag(nsprite int, flag u32, enable bool) bool
pub fn enablespriteflag(nsprite int, flag u32, enable bool) bool {
	return C.TLN_EnableSpriteFlag(nsprite, flag, enable)
}

fn C.TLN_SetSpritePivot(nsprite int, px f32, py f32) bool
pub fn setspritepivot(nsprite int, px f32, py f32) bool {
	return C.TLN_SetSpritePivot(nsprite, px, py)
}

fn C.TLN_SetSpritePosition(nsprite int, x int, y int) bool
pub fn setspriteposition(nsprite int, x int, y int) bool {
	return C.TLN_SetSpritePosition(nsprite, x, y)
}

fn C.TLN_SetSpritePicture(nsprite int, entry int) bool
pub fn setspritepicture(nsprite int, entry int) bool {
	return C.TLN_SetSpritePicture(nsprite, entry)
}

fn C.TLN_SetSpritePalette(nsprite int, palette &C.TLN_Palette) bool
pub fn setspritepalette(nsprite int, palette Palette) bool {
	return C.TLN_SetSpritePalette(nsprite, palette)
}

fn C.TLN_SetSpriteBlendMode(nsprite int, mode Blend, factor u8) bool
pub fn setspriteblendmode(nsprite int, mode Blend, factor u8) bool {
	return C.TLN_SetSpriteBlendMode(nsprite, mode, factor)
}

fn C.TLN_SetSpriteScaling(nsprite int, sx f32, sy f32) bool
pub fn setspritescaling(nsprite int, sx f32, sy f32) bool {
	return C.TLN_SetSpriteScaling(nsprite, sx, sy)
}

fn C.TLN_ResetSpriteScaling(nsprite int) bool
pub fn resetspritescaling(nsprite int) bool {
	return C.TLN_ResetSpriteScaling(nsprite)
}

fn C.TLN_GetSpritePicture(nsprite int) int
pub fn getspritepicture(nsprite int) int {
	return C.TLN_GetSpritePicture(nsprite)
}

pub fn C.TLN_GetSpriteX(nsprite int) int
pub fn getspritex(nsprite int) int {
	return C.TLN_GetSpriteX(nsprite)
}

fn C.TLN_GetSpriteY(nsprite int) int
pub fn getspritey(nsprite int) int {
	return C.TLN_GetSpriteY(nsprite)
}

fn C.TLN_GetAvailableSprite() int
pub fn getavailablesprite() int {
	return C.TLN_GetAvailableSprite()
}

fn C.TLN_EnableSpriteCollision(nsprite int, enable bool) bool
pub fn enablespritecollision(nsprite int, enable bool) bool {
	return C.TLN_EnableSpriteCollision(nsprite, enable)
}

fn C.TLN_GetSpriteCollision(nsprite int) bool
pub fn getspritecollision(nsprite int) bool {
	return C.TLN_GetSpriteCollision(nsprite)
}

fn C.TLN_GetSpriteState(nsprite int, state &C.TLN_SpriteState) bool
pub fn getspritestate(nsprite int, state &SpriteState) bool {
	return C.TLN_GetSpriteState(nsprite, state)
}

fn C.TLN_SetFirstSprite(nsprite int) bool
pub fn setfirstsprite(nsprite int) bool {
	return C.TLN_SetFirstSprite(nsprite)
}

fn C.TLN_SetNextSprite(nsprite int, next int) bool
pub fn setnextsprite(nsprite int, next int) bool {
	return C.TLN_SetNextSprite(nsprite, next)
}

fn C.TLN_EnableSpriteMasking(nsprite int, enable bool) bool
pub fn enablespritemasking(nsprite int, enable bool) bool {
	return C.TLN_EnableSpriteMasking(nsprite, enable)
}

fn C.TLN_SetSpritesMaskRegion(top_line int, bottom_line int)
pub fn setspritesmaskregion(top_line int, bottom_line int) {
	C.TLN_SetSpritesMaskRegion(top_line, bottom_line)
}

fn C.TLN_SetSpriteAnimation(nsprite int, sequence &C.TLN_Sequence, loop int) bool
pub fn setspriteanimation(nsprite int, sequence Sequence, loop int) bool {
	return C.TLN_SetSpriteAnimation(nsprite, sequence, loop)
}

fn C.TLN_DisableSpriteAnimation(nsprite int) bool
pub fn disablespriteanimation(nsprite int) bool {
	return C.TLN_DisableSpriteAnimation(nsprite)
}

fn C.TLN_PauseSpriteAnimation(index int) bool
pub fn pausespriteanimation(index int) bool {
	return C.TLN_PauseSpriteAnimation(index)
}

fn C.TLN_ResumeSpriteAnimation(index int) bool
pub fn resumespriteanimation(index int) bool {
	return C.TLN_ResumeSpriteAnimation(index)
}

fn C.TLN_DisableAnimation(index int) bool
pub fn disableanimation(index int) bool {
	return C.TLN_DisableAnimation(index)
}

fn C.TLN_DisableSprite(nsprite int) bool
pub fn disablesprite(nsprite int) bool {
	return C.TLN_DisableSprite(nsprite)
}

fn C.TLN_GetSpritePalette(nsprite int) Palette
pub fn getspritepalette(nsprite int) Palette {
	return C.TLN_GetSpritePalette(nsprite)
}

fn C.TLN_CreateSequence(name &char, target int, num_frames int, frames &C.TLN_SequenceFrame) Sequence
pub fn createsequence(name string, target int, num_frames int, frames &SequenceFrame) Sequence {
	return C.TLN_CreateSequence(name.str, target, num_frames, frames)
}

fn C.TLN_CreateCycle(name &char, num_strips int, strips &C.TLN_ColorStrip) Sequence
pub fn createcycle(name string, num_strips int, strips &ColorStrip) Sequence {
	return C.TLN_CreateCycle(name.str, num_strips, strips)
}

fn C.TLN_CreateSpriteSequence(name &char, spriteset &C.TLN_Spriteset, basename &char, delay int) Sequence
pub fn createspritesequence(name string, spriteset SpriteSet, basename &char, delay int) Sequence {
	return C.TLN_CreateSpriteSequence(name.str, spriteset, basename, delay)
}

fn C.TLN_CloneSequence(src &C.TLN_Sequence) Sequence
pub fn clonesequence(src C.TLN_Sequence) Sequence {
	return C.TLN_CloneSequence(src)
}

fn C.TLN_GetSequenceInfo(sequence &C.TLN_Sequence, info &C.TLN_SequenceInfo) bool
pub fn getsequenceinfo(sequence Sequence, info &SequenceInfo) bool {
	return C.TLN_GetSequenceInfo(sequence, info)
}

fn C.TLN_DeleteSequence(sequence &C.TLN_Sequence) bool
pub fn deletesequence(sequence Sequence) bool {
	return C.TLN_DeleteSequence(sequence)
}

fn C.TLN_CreateSequencePack() SequencePack
pub fn createsequencepack() SequencePack {
	return C.TLN_CreateSequencePack()
}

fn C.TLN_LoadSequencePack(filename &char) SequencePack
pub fn loadsequencepack(filename string) SequencePack {
	return C.TLN_LoadSequencePack(filename.str)
}

fn C.TLN_GetSequence(sp &C.TLN_SequencePack, index int) Sequence
pub fn getsequence(sp SequencePack, index int) Sequence {
	return C.TLN_GetSequence(sp, index)
}

fn C.TLN_FindSequence(sp &C.TLN_SequencePack, name &char) Sequence
pub fn findsequence(sp SequencePack, name string) Sequence {
	return C.TLN_FindSequence(sp, name.str)
}

fn C.TLN_GetSequencePackCount(sp &C.TLN_SequencePack) int
pub fn getsequencepackcount(sp SequencePack) int {
	return C.TLN_GetSequencePackCount(sp)
}

fn C.TLN_AddSequenceToPack(sp &C.TLN_SequencePack, sequence &C.TLN_Sequence) bool
pub fn addsequencetopack(sp SequencePack, sequence Sequence) bool {
	return C.TLN_AddSequenceToPack(sp, sequence)
}

fn C.TLN_DeleteSequencePack(sp &C.TLN_SequencePack) bool
pub fn deletesequencepack(sp SequencePack) bool {
	return C.TLN_DeleteSequencePack(sp)
}

fn C.TLN_SetPaletteAnimation(index int, palette &C.TLN_Palette, sequence &C.TLN_Sequence, blend bool) bool
pub fn setpaletteanimation(index int, palette Palette, sequence Sequence, blend bool) bool {
	return C.TLN_SetPaletteAnimation(index, palette, sequence, blend)
}

fn C.TLN_SetPaletteAnimationSource(index int, palette &C.TLN_Palette) bool
pub fn setpaletteanimationsource(index int, palette Palette) bool {
	return C.TLN_SetPaletteAnimationSource(index, palette)
}

fn C.TLN_GetAnimationState(index int) bool
pub fn getanimationstate(index int) bool {
	return C.TLN_GetAnimationState(index)
}

fn C.TLN_SetAnimationDelay(index int, frame int, delay int) bool
pub fn setanimationdelay(index int, frame int, delay int) bool {
	return C.TLN_SetAnimationDelay(index, frame, delay)
}

fn C.TLN_GetAvailableAnimation() int
pub fn getavailableanimation() int {
	return C.TLN_GetAvailableAnimation()
}

fn C.TLN_DisablePaletteAnimation(index int) bool
pub fn disablepaletteanimation(index int) bool {
	return C.TLN_DisablePaletteAnimation(index)
}

fn C.TLN_LoadWorld(tmxfile &char, first_layer int) bool
pub fn loadworld(tmxfile string, first_layer int) bool {
	return C.TLN_LoadWorld(tmxfile.str, first_layer)
}

fn C.TLN_SetWorldPosition(x int, y int)
pub fn setworldposition(x int, y int) {
	C.TLN_SetWorldPosition(x, y)
}

fn C.TLN_SetLayerParallaxFactor(nlayer int, x f32, y f32) bool
pub fn setlayerparallaxfactor(nlayer int, x f32, y f32) bool {
	return C.TLN_SetLayerParallaxFactor(nlayer, x, y)
}

fn C.TLN_SetSpriteWorldPosition(nsprite int, x int, y int) bool
pub fn setspriteworldposition(nsprite int, x int, y int) bool {
	return C.TLN_SetSpriteWorldPosition(nsprite, x, y)
}

fn C.TLN_ReleaseWorld()
pub fn releaseworld() {
	C.TLN_ReleaseWorld()
}
