
require "vinx.core.Import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "androidx.appcompat.widget.LinearLayoutCompat"
import "android.widget.*"
import "android.view.*"
import "android.view.MotionEvent"
import "android.graphics.*"
import "android.graphics.drawable.*"
import "android.media.MediaPlayer"
import "android.content.*"
import "android.net.Uri"
import "android.provider.Settings"
import "android.util.DisplayMetrics"
import "android.view.inputmethod.InputMethodManager"
import "android.view.inputmethod.EditorInfo"
import "java.io.File"
import "android.os.Environment"
import "android.text.TextUtils"
import "android.view.animation.*"
import "android.animation.ObjectAnimator"
import "android.view.animation.BounceInterpolator"
import "android.text.util.Linkify"
import "android.text.SpannableString"
import "android.text.style.URLSpan"
import "android.text.method.LinkMovementMethod"
import "android.provider.MediaStore"
import "android.content.Intent"
import "android.database.Cursor"
import "java.io.File"
import "java.io.FileInputStream"
import "java.io.FileOutputStream"
import "android.graphics.Bitmap"
import "android.graphics.BitmapFactory"
import "android.renderscript.RenderScript"
import "android.renderscript.Allocation"
import "android.renderscript.ScriptIntrinsicBlur"
import "android.renderscript.Element"
import "json"
import "com.google.android.material.materialswitch.MaterialSwitch"
import "com.google.android.material.button.MaterialButton"
import "com.google.android.material.switchmaterial.SwitchMaterial"
import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.textfield.TextInputLayout"
import "com.google.android.material.textfield.TextInputEditText"
import "com.google.android.material.slider.Slider"
import "android.content.res.ColorStateList"
import "com.google.android.material.progressindicator.CircularProgressIndicator"
import "com.google.android.material.radiobutton.MaterialRadioButton"
import "android.app.AlertDialog"
import "android.content.Intent"
import "android.net.Uri"
import "android.graphics.drawable.GradientDrawable"
import "android.graphics.Color"
import "android.graphics.drawable.ShapeDrawable"
import "android.graphics.drawable.shapes.RoundRectShape"
import "android.graphics.drawable.StateListDrawable"
import "android.view.WindowManager"
import "android.widget.LinearLayout"
import "android.widget.EditText"
import "android.widget.Button"
import "android.widget.Toast"
import "android.view.Gravity"
import "android.view.animation.Animation"
import "android.view.animation.AlphaAnimation"
import "android.view.animation.TranslateAnimation"
import "android.view.animation.DecelerateInterpolator"
import "android.view.animation.AnimationSet"
import "android.graphics.Bitmap"
import "android.graphics.Canvas"
import "android.graphics.Paint"
import "android.graphics.BlurMaskFilter"
import "android.view.ViewGroup"
import "android.graphics.drawable.BitmapDrawable"
import "android.os.Build"
import "android.graphics.RenderEffect"
import "android.graphics.Shader"
import "android.view.WindowManager"
import "android.view.animation.*"
import "android.graphics.*"
import "android.graphics.drawable.*"
import "android.content.Context"
import "android.animation.ValueAnimator"
import "android.animation.AnimatorSet"
import "android.animation.ObjectAnimator"
import "android.animation.TimeInterpolator"
import "android.animation.Animator"
import "android.content.res.Configuration"
import "android.media.AudioManager"
import "android.media.AudioAttributes"
import "android.os.Build"

activity
.setTheme(R.style.Theme_Material3_Blue)
.setTitle("blue Aurora")
.setContentView(loadlayout("layout"))
if activity.getSupportActionBar() ~= nil then
    activity.getSupportActionBar().hide()
end
function 全屏()
  window = activity.getWindow();
  window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_FULLSCREEN|View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);
  window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
  xpcall(function()
    lp = window.getAttributes();
    lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
    window.setAttributes(lp);
  end,
  function(e)
  end)
end
全屏()

--[[
如果想分多文件,请把加载布局删掉以及调用移动一下
--]]





-- 定义
local display = activity.getWindowManager().getDefaultDisplay()
local metrics = DisplayMetrics()
display.getMetrics(metrics)
local density = metrics.density
local screenWidth = metrics.widthPixels
local screenHeight = metrics.heightPixels

local function dp2px(dp)
  return math.floor(dp * density + 0.5)
end

-- 创建边框和圆角
local function createBorderedRoundRectDrawable(fillColor, borderColor, borderWidthDp, radiusDp)
  local shape = GradientDrawable()
  shape.setShape(GradientDrawable.RECTANGLE)
  shape.setColor(fillColor)
  shape.setStroke(borderWidthDp * density, borderColor)
  shape.setCornerRadius(radiusDp * density)
  return shape
end

-- 检查是否已同意
local shared = activity.getSharedPreferences("qscc", Context.MODE_PRIVATE)
local Qsc = shared.getBoolean("Qsc", false)

if not Qsc then
  activity.setContentView(loadlayout{
    LinearLayout,
    layout_width="-1",
    layout_height="-1",
    backgroundColor=0xFFF8F9FA,
    orientation="vertical",
    {
      View,
      layout_width="-1",
      layout_height="40dp",
    },
    {
      ScrollView,
      layout_width="-1",
      layout_height="-1",
      {
        LinearLayout,
        layout_width="-1",
        layout_height="-1",
        orientation="vertical",
        padding="16dp",
        {
          ImageView,
          layout_width="100dp",
          layout_height="100dp",
          scaleType="fitCenter",
          src="icon.png",
          id="appIcon",
          layout_gravity="center",
          layout_marginBottom="20dp"
        },
        {
          TextView,
          layout_width="-1",
          layout_height="-2",
          text="blue Aurora用户协议与隐私政策",
          id="login",
          textSize="22sp",
          textColor=0xFF212529,
          textStyle="bold",
          gravity="center",
          layout_marginBottom="16dp"
        },
        {
          TextView,
          layout_width="-1",
          layout_height="-2",
          text="1. 数据安全\n我们承诺保护您的个人信息安全，所有数据仅在本地存储，索要储存权限仅用于音乐文件缓存和设置保存，不会上传任何用户数据。\n\n"..
          "2. 权限说明\n应用需要存储权限以保存音乐文件和播放列表，需要网络权限以搜索在线音乐。\n\n"..
          "3. 免责条款\n使用本应用即表示您同意承担相关责任。本应用仅提供音乐播放功能，不提供任何音乐资源。\n\n"..
          "4. 服务条款\n我们保留修改服务条款的权利。本应用可能使用第三方API（如网易云音乐）提供在线搜索服务。\n\n"..
          "5. 版权声明\n请确保您播放的音乐文件拥有合法版权。本应用不承担因版权问题产生的任何责任。\n\n"..
          "6. 免责声明\n使用者需自行承担风险。开发者/提供方不对以下情况负责：\n- 因使用本应用造成的任何直接或间接损失\n- 因版权问题导致的纠纷\n\n"..
          "7. 开源协议\n请严格遵循GNU General Public License version 3.0 (GPLv3)开源协议。\n"..
          "根据GPLv3协议规定，任何对本应用的修改或衍生作品必须：\n"..
          "• 同样以GPLv3协议开源\n"..
          "• 明确标注修改来源\n"..
          "• 包含完整的版权声明和许可声明\n"..
          "• 提供完整的源代码访问方式\n"..
          "• 保留原始作者署名\n\n"..
          "请仔细阅读以上内容\n点击下方按钮表示您已阅读并同意全部条款。",
          textSize="16sp",
          textColor=0xFF212529,
          id="agreementText",
          layout_marginBottom="24dp",
          padding="16dp",
          background=createBorderedRoundRectDrawable(0xFFFFFFFF, 0xFFDEE2E6, 1, 12)
        },
        {
          LinearLayout,
          orientation="horizontal",
          layout_width="-1",
          layout_height="-2",
          gravity="center",
          layout_marginTop="8dp",
          {
            MaterialButton,
            layout_width="0dp",
            layout_height="48dp",
            layout_weight="1",
            text="同意",
            textSize="17sp",
            textColor=0xFFFFFFFF,
            background=createBorderedRoundRectDrawable(0xFF0D6EFD, 0xFF0A58CA, 1, 10),
            padding="8dp",
            layout_marginRight="8dp",
            onClick=function()
              shared.edit().putBoolean("Qsc", true).apply()
              Toast.makeText(activity, "感谢您使用blue Aurora音乐播放器", Toast.LENGTH_SHORT).show()
              activity.newActivity("main")
              activity.finish()
            end,
          },
          {
            MaterialButton,
            layout_width="0dp",
            layout_height="48dp",
            layout_weight="1",
            text="不同意",
            textSize="17sp",
            textColor=0xFF495057,
            background=createBorderedRoundRectDrawable(0xFFE9ECEF, 0xFFCED4DA, 1, 10),
            padding="8dp",
            layout_marginLeft="8dp",
            onClick=function()
              activity.finish()
            end,
          },
        },
      },
    },
  })
  return
end




local appDir = activity.getExternalFilesDir(nil).getAbsolutePath()
local musicDir = appDir .. "/Music"
local bgDir = appDir .. "/Background"

-- 确保目录
local appFolder = File(appDir)
if not appFolder.exists() then
  appFolder.mkdirs()
end
local musicFolder = File(musicDir)
if not musicFolder.exists() then
  musicFolder.mkdirs()
end
local bgFolder = File(bgDir)
if not bgFolder.exists() then
  bgFolder.mkdirs()
end

-- 保存歌曲的全局变量
local savedSongs = {}
local wasPlaying = false
local currentPosition = 0
local currentListType = "search"
local searchResults = {}

-- 记录触摸
local lastTouchX, lastTouchY

local themeColors = {
  {
    name = "雫蓝",
    description = "她的笑容，像清雪一般温柔",
    PRIMARY = Color.parseColor("#B3D9FF"),
    PRIMARY_DARK = Color.parseColor("#B3D9FF"),
    SURFACE = Color.parseColor("#F5F9FF"),
    SURFACE_VARIANT = Color.parseColor("#E6F2FF"),
    ON_SURFACE = Color.parseColor("#336699"),
    BORDER = Color.parseColor("#B3D9FF"),
    CARD_BG = Color.parseColor("#FFFFFF"),
    TEXT_COLOR = Color.parseColor("#336699") 
  },
  {
    name = "雫蓝-二次元定制版",
    description = "界面拥有猫羽雫（Nekoha Shizuku）二次元贴图的主题！\n半成品(配色以及一些东西都不完善)",
    PRIMARY = Color.parseColor("#B3D9FF"),
    PRIMARY = Color.parseColor("#B3D9FF"),
    PRIMARY_DARK = Color.parseColor("#B3D9FF"),
    SURFACE = Color.parseColor("#F5F9FF"),
    SURFACE_VARIANT = Color.parseColor("#E6F2FF"),
    ON_SURFACE = Color.parseColor("#336699"),
    BORDER = Color.parseColor("#B3D9FF"),
    CARD_BG = Color.parseColor("#FFFFFF"),
    TEXT_COLOR = Color.parseColor("#336699") ,
    isAnimeTheme = true
   },
   {
    name = "芙兰-二次元定制版", 
    description = "来自异世界的勇者",
    PRIMARY = Color.parseColor("#D1D5F2"),
    PRIMARY_DARK = Color.parseColor("#D1D5F2"),
    SURFACE = Color.parseColor("#F0F4F9"),
    SURFACE_VARIANT = Color.parseColor("#F5F7FA"),
    ON_SURFACE = Color.parseColor("#c4d7ed"),
    BORDER = Color.parseColor("#F0F4F9"),
    CARD_BG = Color.parseColor("#E5FFFFFF"),
    TEXT_COLOR = Color.parseColor("#c4d7ed"),
    isAnimeTheme = true
    },
  {
    name = "绒灰蓝",
    description = "“或许是一种非常不错的选择呢！”",
    PRIMARY = Color.parseColor("#9DB5D6"),
    PRIMARY_DARK = Color.parseColor("#7A96B8"), 
    SURFACE = Color.parseColor("#F5F9FC"),
    SURFACE_VARIANT = Color.parseColor("#E8EFF7"),
    ON_SURFACE = Color.parseColor("#4A6380"),
    BORDER = Color.parseColor("#C4D3E5"),
    CARD_BG = Color.parseColor("#FFFFFF"),
    TEXT_COLOR = Color.parseColor("#6E8CB3"),
    ACCENT = Color.parseColor("#E0B0D5")
    },
    { 
    name = "薰衣草紫",
    description = "一种很新颖的颜色，对吧",
    PRIMARY = Color.parseColor("#C3A6D2"),
    PRIMARY_DARK = Color.parseColor("#A78BB8"),
    SURFACE = Color.parseColor("#FAF7FC"),
    SURFACE_VARIANT = Color.parseColor("#EEE5F5"),
    ON_SURFACE = Color.parseColor("#3A2E43"),
    BORDER = Color.parseColor("#D8C9E3"),
    CARD_BG = Color.parseColor("#FFFFFF"),
    TEXT_COLOR = Color.parseColor("#7A5C8D")
  },
  {
    name = "自然绿",
    description = "自然清新的绿色主题，生机勃勃",
    PRIMARY = Color.parseColor("#4CAF50"),
    PRIMARY_DARK = Color.parseColor("#81C784"),
    SURFACE = Color.parseColor("#FFFFFF"),
    SURFACE_VARIANT = Color.parseColor("#E8F5E9"),
    ON_SURFACE = Color.parseColor("#202124"),
    BORDER = Color.parseColor("#C8E6C9"),
    CARD_BG = Color.parseColor("#FFFFFF"),
    TEXT_COLOR = Color.parseColor("#2E7D32")
  },
  {
    name = "淡紫",
    description = "遵循Material Design独特规范的淡雅紫色主题",
    PRIMARY = Color.parseColor("#D1C4E9"),
    PRIMARY_DARK = Color.parseColor("#B39DDB"),
    SURFACE = Color.parseColor("#FFFFFF"),
    SURFACE_VARIANT = Color.parseColor("#F5F3F7"),
    ON_SURFACE = Color.parseColor("#424242"),
    BORDER = Color.parseColor("#E6E0E9"),
    CARD_BG = Color.parseColor("#FFFFFF"),
    TEXT_COLOR = Color.parseColor("#7E57C2")
  }
}
--这里全都是变量
local prefs = activity.getSharedPreferences("theme_prefs", Context.MODE_PRIVATE)
local currentThemeIndex = prefs.getInt("theme_index", 1)
local applyThemeToFloatWindow = prefs.getBoolean("apply_to_float", true)
local isFloatWindowTransparent = prefs.getBoolean("float_window_transparent", false)
local useVulkanRender = prefs.getBoolean("use_vulkan_render", true)
local isLowPerformanceMode = prefs.getBoolean("low_performance_mode", false)
local bgPrefs = activity.getSharedPreferences("background_prefs", Context.MODE_PRIVATE)
local isCustomBgEnabled = bgPrefs.getBoolean("enabled", false)
local isBlurEnabled = bgPrefs.getBoolean("blur", true)
local bgImagePath = bgPrefs.getString("path", "")
local cardAlpha = bgPrefs.getInt("card_alpha", 80)
local blurRadius = bgPrefs.getInt("blur_radius", 15)
local dynamicIsland = nil
local isDynamicIslandEnabled = prefs.getBoolean("dynamic_island_enabled", true)
local currentSource = nil
local surroundSoundEnabled = false
local surroundSoundSpeed = 2.0 -- 环绕速度 (0.5-4.0)
local surroundSoundUpdateHandler = Handler()
local surroundSoundUpdateRunnable = nil
local currentAngle = 0 -- 当前角度 (0-2π)
local surroundRadius = 1.0 -- 环绕半径
local lastVolumeLeft = 1.0 -- 记录上次音量
local lastVolumeRight = 1.0
local surroundSoundEnabled = prefs.getBoolean("surround_enabled", true)
local surroundSoundSpeed = tonumber(prefs.getString("surround_speed", "2.0")) or 2.0
local display = activity.getWindowManager().getDefaultDisplay()
local metrics = DisplayMetrics()
display.getMetrics(metrics)
local density = metrics.density
local screenWidth = metrics.widthPixels
local screenHeight = metrics.heightPixels
--灵动岛进度条
local function createIslandProgressDrawable()
    local bg = GradientDrawable()
    bg.setShape(GradientDrawable.RECTANGLE)
    bg.setColor(0x55FFFFFF)
    bg.setCornerRadius(dp2px(2))
    
    local progress = GradientDrawable()
    progress.setShape(GradientDrawable.RECTANGLE)
    progress.setColor(0xFFFFFFFF)
    progress.setCornerRadius(dp2px(2))
    
    local layers = LayerDrawable({bg, progress})
    layers.setId(0, android.R.id.background)
    layers.setId(1, android.R.id.progress)
    
    return layers
end
-- 时间格式化
local function formatTime(milliseconds)
    local totalSeconds = math.floor(milliseconds / 1000)
    local minutes = math.floor(totalSeconds / 60)
    local seconds = totalSeconds % 60
    return string.format("%d:%02d", minutes, seconds)
end

local function dp2px(dp)
  return math.floor(dp * density + 0.5)
end

local function createRoundRectDrawable(color, radiusDp)
  local shape = GradientDrawable()
  shape.setShape(GradientDrawable.RECTANGLE)
  shape.setColor(color)
  shape.setCornerRadius(radiusDp * density)
  return shape
end

local function createBorderDrawable(fillColor, strokeColor, strokeWidthDp, radiusDp)
  local shape = GradientDrawable()
  shape.setShape(GradientDrawable.RECTANGLE)
  shape.setColor(fillColor)
  shape.setCornerRadius(radiusDp * density)
  shape.setStroke(math.floor(strokeWidthDp * density), strokeColor)
  return shape
end

local function createButtonDrawable(normalColor, pressedColor, radiusDp)
  local states = StateListDrawable()
  states.addState({android.R.attr.state_pressed}, createRoundRectDrawable(pressedColor, radiusDp))
  states.addState({}, createRoundRectDrawable(normalColor, radiusDp))
  return states
end

local function createProgressDrawable()
  local track = GradientDrawable()
  track.setShape(GradientDrawable.RECTANGLE)
  track.setColor(COLOR_SURFACE_VARIANT)
  track.setCornerRadius(dp2px(4))
  track.setStroke(dp2px(1), COLOR_BORDER)

  local progress = GradientDrawable()
  progress.setShape(GradientDrawable.RECTANGLE)
  progress.setColor(COLOR_PRIMARY)
  progress.setCornerRadius(dp2px(4))

  local progressClip = ClipDrawable(progress, Gravity.LEFT, ClipDrawable.HORIZONTAL)
  local layers = { track, progressClip }
  local layerDrawable = LayerDrawable(layers)
  layerDrawable.setId(0, android.R.id.background)
  layerDrawable.setId(1, android.R.id.progress)

  local inset = dp2px(4)
  layerDrawable.setLayerInset(0, inset, 0, inset, 0)
  layerDrawable.setLayerInset(1, inset, 0, inset, 0)

  return layerDrawable
end

local function updateThemeColors()
  local currentTheme = themeColors[currentThemeIndex]
  COLOR_PRIMARY = currentTheme.PRIMARY
  COLOR_PRIMARY_DARK = currentTheme.PRIMARY_DARK
  COLOR_ON_PRIMARY = Color.parseColor("#FFFFFF")
  COLOR_SURFACE = currentTheme.SURFACE
  COLOR_ON_SURFACE = currentTheme.ON_SURFACE
  COLOR_SURFACE_VARIANT = currentTheme.SURFACE_VARIANT
  COLOR_ON_SURFACE_VAR = Color.parseColor("#757575")
  COLOR_ERROR = Color.parseColor("#F44336")
  COLOR_ON_ERROR = Color.parseColor("#FFFFFF")
  COLOR_BORDER = currentTheme.BORDER
  COLOR_CARD_BG = currentTheme.CARD_BG
  COLOR_TEXT = currentTheme.TEXT_COLOR
end

updateThemeColors()

local cachedBackgroundBitmap = nil
local cachedBlurredBitmap = nil

local function createDynamicIsland()
    if not Settings.canDrawOverlays(activity) then
        return nil
    end

    local wm = activity.getSystemService(Context.WINDOW_SERVICE)
    local metrics = activity.getResources().getDisplayMetrics()
    
    local statusBarHeight = 0
    local resourceId = activity.getResources().getIdentifier("status_bar_height", "dimen", "android")
    if resourceId > 0 then
        statusBarHeight = activity.getResources().getDimensionPixelSize(resourceId)
    end
    
    local params = WindowManager.LayoutParams()
    params.width = WindowManager.LayoutParams.WRAP_CONTENT
    params.height = WindowManager.LayoutParams.WRAP_CONTENT
    params.type = WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
    params.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE |
                  WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS
    params.format = PixelFormat.TRANSLUCENT
    params.gravity = Gravity.TOP | Gravity.CENTER_HORIZONTAL
    params.x = 0
    params.y = statusBarHeight + dp2px(-25)
    
    local container = FrameLayout(activity)
    container.setLayoutParams(ViewGroup.LayoutParams(-1, -1))
    
    --灵动岛尺寸与面板
    local collapsedWidth = dp2px(110)
    local collapsedHeight = dp2px(35)
    local expandedWidth = dp2px(320)
    local expandedHeight = dp2px(130)
    
    --主视图
    local island = LinearLayout(activity)
    island.setLayoutParams(ViewGroup.LayoutParams(collapsedWidth, collapsedHeight))
    island.setBackground(createBorderDrawable(0xFF1C1C1E, 0x55FFFFFF, dp2px(0.5), dp2px(14)))
    island.setElevation(dp2px(8))
    island.setOrientation(LinearLayout.VERTICAL)
    island.setPadding(dp2px(12), dp2px(8), dp2px(12), dp2px(8))
    island.setClipToOutline(true)
    
    --状态指示灯
    local dot = View(activity)
    dot.setLayoutParams(LinearLayout.LayoutParams(dp2px(6), dp2px(6)))
    dot.setBackground(createBorderDrawable(0x55FFA500, 0, dp2px(0.5), dp2px(3)))
    island.addView(dot)
    
    -- 音乐控制面板
    local musicPanel = LinearLayout(activity)
    musicPanel.setLayoutParams(ViewGroup.LayoutParams(-1, -1))
    musicPanel.setOrientation(LinearLayout.VERTICAL)
    musicPanel.setGravity(Gravity.CENTER_HORIZONTAL)
    musicPanel.setVisibility(View.GONE)
    musicPanel.setPadding(dp2px(16), dp2px(6), dp2px(16), dp2px(6))
    
    -- 歌曲信息
    local songTitle = TextView(activity)
    songTitle.setText("未播放音乐")
    songTitle.setTextColor(0xFFFFFFFF)
    songTitle.setTextSize(14)
    songTitle.setTypeface(Typeface.DEFAULT_BOLD)
    songTitle.setEllipsize(TextUtils.TruncateAt.END)
    songTitle.setSingleLine(true)
    songTitle.setLayoutParams(ViewGroup.LayoutParams(-1, -2))
    
    local artistName = TextView(activity)
    artistName.setText("点击播放")
    artistName.setTextColor(0xFFAAAAAA)
    artistName.setTextSize(12)
    artistName.setPadding(0, dp2px(2), 0, dp2px(4))
    artistName.setLayoutParams(ViewGroup.LayoutParams(-1, -2))
    
    -- 进度条
    local progressBar = ProgressBar(activity, nil, android.R.attr.progressBarStyleHorizontal)
    progressBar.setLayoutParams(ViewGroup.LayoutParams(-1, dp2px(2)))
    progressBar.setProgressDrawable(createIslandProgressDrawable())
    progressBar.setMax(1000)
    
    -- 时间显示
    local timeLayout = LinearLayout(activity)
    timeLayout.setLayoutParams(ViewGroup.LayoutParams(-1, -2))
    timeLayout.setPadding(0, dp2px(2), 0, dp2px(4))
    
    local currentTime = TextView(activity)
    currentTime.setText("0:00")
    currentTime.setTextColor(0xFFAAAAAA)
    currentTime.setTextSize(10)
    currentTime.setLayoutParams(LinearLayout.LayoutParams(-2, -2, 1))
    
    local totalTime = TextView(activity)
    totalTime.setText("0:00")
    totalTime.setTextColor(0xFFAAAAAA)
    totalTime.setTextSize(10)
    
    timeLayout.addView(currentTime)
    timeLayout.addView(totalTime)
    
    -- 控制按钮面板
    local controlsLayout = LinearLayout(activity)
    controlsLayout.setLayoutParams(ViewGroup.LayoutParams(-1, dp2px(50)))
    controlsLayout.setGravity(Gravity.CENTER)
    controlsLayout.setPadding(0, dp2px(1), 0, dp2px(1))
    controlsLayout.setBackgroundColor(Color.TRANSPARENT)
    
    -- 按钮
    local prevBtn = ImageView(activity)
    prevBtn.setLayoutParams(LinearLayout.LayoutParams(dp2px(26), dp2px(26)))
    prevBtn.setImageBitmap(loadbitmap("res/sys.png"))
    prevBtn.setScaleType(ImageView.ScaleType.FIT_CENTER)
    prevBtn.setBackgroundColor(Color.TRANSPARENT)
    prevBtn.setPadding(dp2px(4), dp2px(4), dp2px(4), dp2px(4))
    
    local playBtn = ImageView(activity)
    playBtn.setLayoutParams(LinearLayout.LayoutParams(dp2px(30), dp2px(30)))
    playBtn.setImageBitmap(loadbitmap("res/zt.png"))
    playBtn.setScaleType(ImageView.ScaleType.FIT_CENTER)
    playBtn.setBackgroundColor(Color.TRANSPARENT)
    playBtn.setPadding(dp2px(4), dp2px(4), dp2px(4), dp2px(4))
    
    local nextBtn = ImageView(activity)
    nextBtn.setLayoutParams(LinearLayout.LayoutParams(dp2px(26), dp2px(26)))
    nextBtn.setImageBitmap(loadbitmap("res/xys.png"))
    nextBtn.setScaleType(ImageView.ScaleType.FIT_CENTER)
    nextBtn.setBackgroundColor(Color.TRANSPARENT)
    nextBtn.setPadding(dp2px(4), dp2px(4), dp2px(4), dp2px(4))
    
    -- 按钮间距
    local space1 = View(activity)
    space1.setLayoutParams(LinearLayout.LayoutParams(dp2px(10), dp2px(1)))
    
    local space2 = View(activity)
    space2.setLayoutParams(LinearLayout.LayoutParams(dp2px(10), dp2px(1)))
    
    controlsLayout.addView(prevBtn)
    controlsLayout.addView(space1)
    controlsLayout.addView(playBtn)
    controlsLayout.addView(space2)
    controlsLayout.addView(nextBtn)
    
    --明白的都明白
    musicPanel.addView(songTitle)
    musicPanel.addView(artistName)
    musicPanel.addView(progressBar)
    musicPanel.addView(timeLayout)
    musicPanel.addView(controlsLayout)
    island.addView(musicPanel)
    container.addView(island)
    wm.addView(container, params)
    
    --动画逻辑
    local isExpanded = false
    local animating = false
    
    local function toggleIsland()
        if animating then return end
        animating = true
        
        if isExpanded then
            dot.setVisibility(View.VISIBLE)
        else
            dot.setVisibility(View.GONE)
        end
        
        local animSet = AnimatorSet()
        local animations = {
            ValueAnimator.ofInt({island.getWidth(), isExpanded and collapsedWidth or expandedWidth}),
            ValueAnimator.ofInt({island.getHeight(), isExpanded and collapsedHeight or expandedHeight})
        }
        
        animations[1].addUpdateListener(function(a)
            island.getLayoutParams().width = a.getAnimatedValue()
            island.requestLayout()
        end)
        
        animations[2].addUpdateListener(function(a)
            local h = a.getAnimatedValue()
            island.getLayoutParams().height = h
            island.setBackground(createBorderDrawable(
                0xFF1C1C1E, 0x55FFFFFF, dp2px(0.5), math.min(h/2, dp2px(8))))
            island.requestLayout()
        end)
        
        animSet.playTogether(animations)
        animSet.setDuration(300)
        animSet.setInterpolator(DecelerateInterpolator())
        animSet.addListener({
            onAnimationStart = function()
                if not isExpanded then 
                    musicPanel.setVisibility(View.VISIBLE)
                end
            end,
            onAnimationEnd = function()
                isExpanded = not isExpanded
                animating = false
            end
        })
        
        animSet.start()
    end
    
    local dotAnim = ValueAnimator.ofFloat({0,1})
    dotAnim.setDuration(1500)
    dotAnim.setRepeatCount(ValueAnimator.INFINITE)
    dotAnim.addUpdateListener{
        onAnimationUpdate=function(a)
            local alpha = 0x55 + math.floor(0xAA * math.abs(math.sin(a.getAnimatedValue() * math.pi)))
            dot.setBackground(createBorderDrawable(
                0xFFA500 | (alpha * 0x1000000), 
                0, 
                dp2px(0.5), 
                dp2px(3)))
        end
    }
    
    island.setOnTouchListener(function(v, event)
        if event.getAction() == MotionEvent.ACTION_DOWN then
            v.setBackground(createBorderDrawable(0xFF2C2C2E, 0x55FFFFFF, dp2px(0.5), dp2px(8)))
            return true
        elseif event.getAction() == MotionEvent.ACTION_UP then
            v.setBackground(createBorderDrawable(0xFF1C1C1E, 0x55FFFFFF, dp2px(0.5), dp2px(8)))
            toggleIsland()
            return true
        end
        return false
    end)
    
    return {
        view = container,
        params = params,
        setSongInfo = function(title, artist)
            songTitle.setText(title)
            artistName.setText(artist)
        end,
        setProgress = function(current, total)
            progressBar.setProgress(math.floor((current/total)*1000))
            currentTime.setText(formatTime(current))
            totalTime.setText(formatTime(total))
        end,
        setPlayState = function(playing)
            playBtn.setImageBitmap(loadbitmap(playing and "res/zt.png" or "res/bf.png"))
        end,
        setOnPlayClick = function(listener)
            playBtn.onClick = listener
        end,
        setOnPrevClick = function(listener)
            prevBtn.onClick = listener
        end,
        setOnNextClick = function(listener)
            nextBtn.onClick = listener
        end,
        show = function()
            container.setVisibility(View.VISIBLE)
            dotAnim.start()
            dot.setVisibility(View.VISIBLE)
        end,
        hide = function()
            container.setVisibility(View.GONE)
            dotAnim.cancel()
        end,
        destroy = function()
            wm.removeView(container)
            dotAnim.cancel()
        end
    }
end

----------模糊
local function zoomBitmap(bitmap, scale)
  local w = bitmap.getWidth()
  local h = bitmap.getHeight()
  local matrix = Matrix()
  matrix.postScale(scale, scale)
  return Bitmap.createBitmap(bitmap, 0, 0, w, h, matrix, true)
end

local function blur(context, bitmap, blurRadius)
  if blurRadius <= 0 then
    return bitmap
  end
  
  if useVulkanRender then
    local scale = 0.25
    local smallBitmap = zoomBitmap(bitmap, scale)
    blurRadius = math.max(1, math.min(25, blurRadius))
    
    local success, result = pcall(function()
      return context.vulkanBlur(smallBitmap, blurRadius)
    end)
    
    if success and result then
      return zoomBitmap(result, 1/scale)
    else
      if not renderScript then
        renderScript = RenderScript.create(context)
      end

      local input = Allocation.createFromBitmap(renderScript, smallBitmap)
      local output = Allocation.createTyped(renderScript, input.getType())
      local blurScript = ScriptIntrinsicBlur.create(renderScript, Element.U8_4(renderScript))
      blurScript.setRadius(blurRadius)
      blurScript.setInput(input)
      blurScript.forEach(output)
      output.copyTo(smallBitmap)

      input.destroy()
      output.destroy()
      blurScript.destroy()
      return zoomBitmap(smallBitmap, 1/scale)
    end
  else
    local scale = 0.25
    local smallBitmap = zoomBitmap(bitmap, scale)
    blurRadius = math.max(1, math.min(25, blurRadius))
    
    if not renderScript then
      renderScript = RenderScript.create(context)
    end

    local input = Allocation.createFromBitmap(renderScript, smallBitmap)
    local output = Allocation.createTyped(renderScript, input.getType())
    local blurScript = ScriptIntrinsicBlur.create(renderScript, Element.U8_4(renderScript))
    blurScript.setRadius(blurRadius)
    blurScript.setInput(input)
    blurScript.forEach(output)
    output.copyTo(smallBitmap)

    input.destroy()
    output.destroy()
    blurScript.destroy()

    return zoomBitmap(smallBitmap, 1/scale)
  end
end

local function createCardBackground(alphaValue)
  local bgDrawable = GradientDrawable()
  bgDrawable.setShape(GradientDrawable.RECTANGLE)
  bgDrawable.setCornerRadius(dp2px(12))
  bgDrawable.setColor(COLOR_CARD_BG)
  bgDrawable.setStroke(dp2px(1), COLOR_BORDER)
  bgDrawable.setAlpha(math.floor(alphaValue * 2.55))
  return bgDrawable
end

local function resetToDefaultBackground()
  if mainLayout then
    mainLayout.setBackground(createRoundRectDrawable(COLOR_SURFACE, 0))

    local alpha = 100
    local cardViews = {
      searchLayout, listLayout, progressLayout, controlLayout
    }

    for _, view in ipairs(cardViews) do
      if view then
        view.setBackground(createCardBackground(alpha))
      end
    end
  end
end

local function loadAndCacheBackground()
    if isLowPerformanceMode then
        cachedBackgroundBitmap = nil
        cachedBlurredBitmap = nil
        return
    end

    if isCustomBgEnabled and bgImagePath ~= "" and File(bgImagePath).exists() then
        local options = BitmapFactory.Options()
        cachedBackgroundBitmap = BitmapFactory.decodeFile(bgImagePath, options)

        if cachedBackgroundBitmap then
            local scaleX = screenWidth / cachedBackgroundBitmap.getWidth()
            local scaleY = screenHeight / cachedBackgroundBitmap.getHeight()
            local scale = math.max(scaleX, scaleY) * 1.1

            local matrix = Matrix()
            matrix.postScale(scale, scale)
            cachedBackgroundBitmap = Bitmap.createBitmap(cachedBackgroundBitmap, 0, 0, 
                cachedBackgroundBitmap.getWidth(), cachedBackgroundBitmap.getHeight(), matrix, true)

            if isBlurEnabled and blurRadius > 0 then
                cachedBlurredBitmap = blur(activity, cachedBackgroundBitmap, blurRadius)
            else
                cachedBlurredBitmap = cachedBackgroundBitmap
            end
        end
    else
        cachedBackgroundBitmap = nil
        cachedBlurredBitmap = nil
    end
end

local function applyBackground()
    resetToDefaultBackground()
    
    if isLowPerformanceMode then
        return
    end
    
    if cachedBlurredBitmap then
        local bgDrawable = Drawable({
            draw = function(canvas)
                local bmWidth = cachedBlurredBitmap.getWidth()
                local bmHeight = cachedBlurredBitmap.getHeight()
                local left = (screenWidth - bmWidth) / 2
                local top = (screenHeight - bmHeight) / 2
                canvas.drawBitmap(cachedBlurredBitmap, left, top, nil)
            end
        })

        if mainLayout then
            mainLayout.setBackground(bgDrawable)

            local cardViews = {
                searchLayout, listLayout, progressLayout, controlLayout
            }
            for _, view in ipairs(cardViews) do
                if view then
                    view.setBackground(createCardBackground(cardAlpha))
                end
            end
        end
    end
end

loadAndCacheBackground()

local db = activity.openOrCreateDatabase("music.db", Context.MODE_PRIVATE, nil)
db.execSQL([[
CREATE TABLE IF NOT EXISTS songs (
    id TEXT PRIMARY KEY,
    name TEXT,
    artist TEXT,
    url TEXT,
    localPath TEXT
);
]])

db.execSQL([[
CREATE TABLE IF NOT EXISTS favorites (
    id TEXT PRIMARY KEY,
    name TEXT,
    artist TEXT,
    url TEXT,
    localPath TEXT
);
]])

local function loadSavedSongs()
  local results = {}
  local cursor = db.rawQuery("SELECT id, name, artist, url, localPath FROM songs", nil)
  if cursor then
    while cursor.moveToNext() do
      local localPath = cursor.getString(4)
      local fileExists = localPath and File(localPath).exists() or false
      if fileExists then
        table.insert(results, {
          id = cursor.getString(0),
          name = cursor.getString(1),
          artist = cursor.getString(2),
          url = cursor.getString(3),
          localPath = localPath
        })
       else
        db.execSQL("DELETE FROM songs WHERE id = ?", {cursor.getString(0)})
      end
    end
    cursor.close()
  end
  return results
end

local function loadFavorites()
  local results = {}
  local cursor = db.rawQuery("SELECT id, name, artist, url, localPath FROM favorites", nil)
  if cursor then
    while cursor.moveToNext() do
      table.insert(results, {
        id = cursor.getString(0),
        name = cursor.getString(1),
        artist = cursor.getString(2),
        url = cursor.getString(3),
        localPath = cursor.getString(4)
      })
    end
    cursor.close()
  end
  return results
end

local function refreshFavoritesList()
  favorites = loadFavorites()
  if currentListType == "favorites" then
    local favAdapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1)
    for i, fav in ipairs(favorites) do
      favAdapter.add(fav.name .. "\n" .. fav.artist)
    end
    lvSongs.setAdapter(favAdapter)
    tvListTitle.text = "收藏列表 " .. #favorites .. " 首"
    songs = favorites
  end
end

local function insertSongToDB(entry)
  db.execSQL("DELETE FROM songs WHERE id = ?", {entry.id})
  local stmt = db.compileStatement("INSERT INTO songs(id, name, artist, url, localPath) VALUES (?, ?, ?, ?, ?);")
  stmt.bindString(1, entry.id)
  stmt.bindString(2, entry.name)
  stmt.bindString(3, entry.artist)
  stmt.bindString(4, entry.url)
  stmt.bindString(5, entry.localPath or "")
  stmt.executeInsert()
  stmt.close()
end

local function addToFavorites(entry)
  db.execSQL("DELETE FROM favorites WHERE id = ?", {entry.id})
  local stmt = db.compileStatement("INSERT INTO favorites(id, name, artist, url, localPath) VALUES (?, ?, ?, ?, ?);")
  stmt.bindString(1, entry.id)
  stmt.bindString(2, entry.name)
  stmt.bindString(3, entry.artist)
  stmt.bindString(4, entry.url)
  stmt.bindString(5, entry.localPath or "")
  stmt.executeInsert()
  stmt.close()
end

local function deleteSongFromDB(songId)
  local cursor = db.rawQuery("SELECT localPath FROM songs WHERE id = ?", {songId})
  local localPath = nil
  if cursor and cursor.moveToFirst() then
    localPath = cursor.getString(0)
    cursor.close()
  end
  db.execSQL("DELETE FROM songs WHERE id = ?;", {songId})
  if localPath and localPath ~= "" then
    pcall(function()
      os.remove(localPath)
    end)
  end
end

local function removeFromFavorites(songId)
  db.execSQL("DELETE FROM favorites WHERE id = ?;", {songId})
end

local songs = {}
local favorites = {}
local currentSong = nil
local isPlaying = false
local isLooping = false
local mediaPlayer = MediaPlayer()
local updateProgressHandler = Handler()
local updateProgressRunnable = nil

local function formatTime(milliseconds)
  local totalSeconds = math.floor(milliseconds / 1000)
  local minutes = math.floor(totalSeconds / 60)
  local seconds = totalSeconds % 60
  return string.format("%02d:%02d", minutes, seconds)
end

local function updateProgress()
    if mediaPlayer and mediaPlayer.isPlaying() then
        local currentPosition = mediaPlayer.getCurrentPosition()
        local duration = mediaPlayer.getDuration()
        if duration > 0 then
            local prog = math.floor((currentPosition / duration) * 1000)
            activity.runOnUiThread(function()
                pbSong.setProgress(prog)
                tvCurrentTime.text = formatTime(currentPosition)
                tvTotalTime.text = formatTime(duration)
                if xfq_pbSong then
                    xfq_pbSong.setProgress(prog)
                    xfq_tvCurrentTime.text = formatTime(currentPosition)
                    xfq_tvTotalTime.text = formatTime(duration)
                end
                
                if isDynamicIslandEnabled and dynamicIsland then
                    dynamicIsland.setProgress(currentPosition, duration)
                end
            end)
        end
        updateProgressHandler.postDelayed(updateProgressRunnable, 500)
    end
end

updateProgressRunnable = Runnable({
  run = function()
    updateProgress()
  end
})




local function calculate3DSound(angle)
    local left = 0.7 + 0.3 * math.sin(angle)
    local right = 0.7 + 0.3 * math.cos(angle)
    
    local echoFactor = 0.15 * math.sin(angle * 0.8)
    left = left + echoFactor
    right = right - echoFactor
    
 
    left = math.max(0.4, math.min(1.0, left))
    right = math.max(0.4, math.min(1.0, right))
    
   
    left = lastVolumeLeft + math.max(-0.15, math.min(0.15, left - lastVolumeLeft))
    right = lastVolumeRight + math.max(-0.15, math.min(0.15, right - lastVolumeRight))
    
    lastVolumeLeft = left
    lastVolumeRight = right
    
    return left, right
end

local function updateSurroundSound()
    if mediaPlayer and isPlaying and surroundSoundEnabled then
        currentAngle = currentAngle + (0.025 * surroundSoundSpeed)
        if currentAngle > 2 * math.pi then
            currentAngle = currentAngle - 2 * math.pi
        end
        
        -- 计算3D音效
        local leftVolume, rightVolume = calculate3DSound(currentAngle)
        
        -- 应用3D效果
        mediaPlayer.setVolume(leftVolume, rightVolume)
        
     
        surroundSoundUpdateHandler.postDelayed(surroundSoundUpdateRunnable, 25)
    end
end

surroundSoundUpdateRunnable = Runnable({
    run = function()
        updateSurroundSound()
    end
})


local function playMusic(entry)
    if mediaPlayer == nil then
        mediaPlayer = MediaPlayer()
    end
    mediaPlayer.reset()
    currentSong = entry
    tvStatus.text = "正在准备: " .. entry.name
    
  
    if Build.VERSION.SDK_INT >= 21 then
        mediaPlayer.setAudioAttributes(AudioAttributes.Builder()
            .setUsage(AudioAttributes.USAGE_MEDIA)
            .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
            .build())
    else
        mediaPlayer.setAudioStreamType(AudioManager.STREAM_MUSIC)
    end
    
  
    if isDynamicIslandEnabled and dynamicIsland then
        dynamicIsland.setSongInfo(entry.name, entry.artist)
        dynamicIsland.show()
    end
    
    local source = entry.localPath or entry.url
    if entry.localPath and not File(entry.localPath).exists() then
        tvStatus.text = "本地文件不存在，尝试在线播放"
        source = entry.url
        entry.localPath = nil
        db.execSQL("UPDATE songs SET localPath = NULL WHERE id = ?", {entry.id})
    end
    
    mediaPlayer.setOnErrorListener({
        onError = function(mp, what, extra)
            tvStatus.text = "播放错误: " .. what .. ", " .. extra
            return true
        end
    })
    
    mediaPlayer.setOnPreparedListener({
        onPrepared = function(mp)
          
            currentAngle = 0
            lastVolumeLeft = 1.0
            lastVolumeRight = 1.0
            
         
            mp.setLooping(isLooping)
            mp.start()
            isPlaying = true
            btnPlay.text = "暂停"
            tvStatus.text = "正在播放: " .. entry.name
            pbSong.setProgress(0)
            tvCurrentTime.text = "00:00"
            tvTotalTime.text = formatTime(mp.getDuration())
            
          
            if surroundSoundEnabled then
                surroundSoundUpdateHandler.post(surroundSoundUpdateRunnable)
            else
                mediaPlayer.setVolume(1, 1) 
            end
            
         
            if isDynamicIslandEnabled and dynamicIsland then
                dynamicIsland.setPlayState(true)
                dynamicIsland.setProgress(0, mp.getDuration())
            end
            
            updateProgressHandler.removeCallbacks(updateProgressRunnable)
            updateProgressHandler.post(updateProgressRunnable)
        end
    })
    
    mediaPlayer.setOnCompletionListener({
        onCompletion = function(mp)
            if not isLooping then
                isPlaying = false
                btnPlay.text = "播放"
                tvStatus.text = "播放完成: " .. entry.name
                
        
                surroundSoundUpdateHandler.removeCallbacks(surroundSoundUpdateRunnable)
                
 
                if isDynamicIslandEnabled and dynamicIsland then
                    dynamicIsland.setPlayState(false)
                end
                
                updateProgressHandler.removeCallbacks(updateProgressRunnable)
            end
        end
    })
    
    pcall(function()
        mediaPlayer.setDataSource(source)
        mediaPlayer.prepareAsync()
    end)
end

local function togglePlayPause()
    if currentSong == nil then
        tvStatus.text = "请先选择歌曲"
        return
    end
    
    if mediaPlayer == nil then
        mediaPlayer = MediaPlayer()
        playMusic(currentSong)
        return
    end
    
    xpcall(function()
        if mediaPlayer.isPlaying() then
            mediaPlayer.pause()
            isPlaying = false
            btnPlay.text = "播放"
            tvStatus.text = "已暂停: " .. currentSong.name
            
            surroundSoundUpdateHandler.removeCallbacks(surroundSoundUpdateRunnable)
            
            if isDynamicIslandEnabled and dynamicIsland then
                dynamicIsland.setPlayState(false)
            end
            
            updateProgressHandler.removeCallbacks(updateProgressRunnable)
        else
            mediaPlayer.start()
            isPlaying = true
            btnPlay.text = "暂停"
            tvStatus.text = "正在播放: " .. currentSong.name
            
            if surroundSoundEnabled then
                surroundSoundUpdateHandler.post(surroundSoundUpdateRunnable)
            else
                mediaPlayer.setVolume(1, 1)
            end
            
            if isDynamicIslandEnabled and dynamicIsland then
                dynamicIsland.setPlayState(true)
            end
            
            updateProgress()
        end
    end, function(e)
        print("播放控制错误: "..tostring(e))
        if mediaPlayer then
            mediaPlayer.release()
        end
        mediaPlayer = MediaPlayer()
        playMusic(currentSong)
    end)
end

local function togglePlayPause()
    if currentSong == nil then
        tvStatus.text = "请先选择歌曲"
        return
    end
    
    if mediaPlayer == nil then
        mediaPlayer = MediaPlayer()
        playMusic(currentSong)
        return
    end
    
    xpcall(function()
        if mediaPlayer.isPlaying() then
            mediaPlayer.pause()
            isPlaying = false
            btnPlay.text = "播放"
            tvStatus.text = "已暂停: " .. currentSong.name
            
            surroundSoundUpdateHandler.removeCallbacks(surroundSoundUpdateRunnable)
            
            if isDynamicIslandEnabled and dynamicIsland then
                dynamicIsland.setPlayState(false)
            end
            
            updateProgressHandler.removeCallbacks(updateProgressRunnable)
        else
            mediaPlayer.start()
            isPlaying = true
            btnPlay.text = "暂停"
            tvStatus.text = "正在播放: " .. currentSong.name
            
            -- 恢复播放时启动环绕音效
            if surroundSoundEnabled then
                surroundSoundUpdateHandler.post(surroundSoundUpdateRunnable)
            else
                mediaPlayer.setVolume(1, 1) -- 普通立体声
            end
            
            if isDynamicIslandEnabled and dynamicIsland then
                dynamicIsland.setPlayState(true)
            end
            
            updateProgress()
        end
    end, function(e)
        print("播放控制错误: "..tostring(e))
        if mediaPlayer then
            mediaPlayer.release()
        end
        mediaPlayer = MediaPlayer()
        playMusic(currentSong)
    end)
end

local function toggleLooping()
  isLooping = not isLooping
  if mediaPlayer then
    mediaPlayer.setLooping(isLooping)
  end
  if isLooping then
    btnLoop.setImageBitmap(loadbitmap("kyxh.png"))
    if xfq_btnLoop then
      xfq_btnLoop.setImageBitmap(loadbitmap("kyxh.png"))
    end
    Toast.makeText(activity, "循环播放已开启", Toast.LENGTH_SHORT).show()
  else
    btnLoop.setImageBitmap(loadbitmap("gbzt.png"))
    if xfq_btnLoop then
      xfq_btnLoop.setImageBitmap(loadbitmap("gbzt.png"))
    end
    Toast.makeText(activity, "循环播放已关闭", Toast.LENGTH_SHORT).show()
  end
end



local function createMainUI()
  return {
    RelativeLayout,
    layout_width = "match_parent",
    layout_height = "match_parent",
    {
      LinearLayout,
      id = "mainLayout",
      orientation = "vertical",
      layout_width = "match_parent",
      layout_height = "match_parent",
      paddingTop = "56dp",
      paddingLeft = "16dp",
      paddingRight = "16dp",
      paddingBottom = "16dp",
      background = createRoundRectDrawable(COLOR_SURFACE, 0),
      
      themeColors[currentThemeIndex].isAnimeTheme and {
        ImageView,
        layout_width = "120dp",
        layout_height = "120dp",
        scaleType = "fitCenter",
        src = currentThemeIndex == 2 and "Nekoha Shizuku/paneko.png" or "Fran/FranzJm.png",
        layout_gravity = "center",
        layout_marginBottom = "20dp",
        elevation = "8dp",
        id = "animeDecoration"
      } or nil,
      
      {
        MaterialCardView,
        id = "searchLayout",
        layout_width = "match_parent",
        layout_height = "wrap_content",
        cardBackgroundColor = COLOR_CARD_BG,
        strokeColor = COLOR_BORDER,
        strokeWidth = "1dp",
        radius = "12dp",
        elevation = "0dp",
        layout_marginBottom = "8dp",
        {
          LinearLayout,
          orientation = "vertical",
          layout_width = "match_parent",
          layout_height = "wrap_content",
          padding = "12dp",
          {
            LinearLayout,
            orientation = "horizontal",
            layout_width = "match_parent",
            layout_height = "36dp",
            gravity = "center_vertical",
            {
              EditText,
              id = "etSearch",
              layout_width = "0dp",
              layout_height = "match_parent",
              layout_weight = "1",
              layout_marginRight = "8dp",
              hint = "输入歌曲名或歌手",
              textColor = COLOR_TEXT,
              textSize = "14sp",
              singleLine = true,
              imeOptions = "actionSearch",
              gravity = "center_vertical",
              background = createBorderDrawable(COLOR_CARD_BG, COLOR_BORDER, 1, 6),
              padding = "8dp"
            },
            {
              MaterialButton,
              id = "btnHistory",
              text = "历史",
              layout_width = "68dp",
              layout_height = "match_parent",
              textColor = COLOR_ON_PRIMARY,
              backgroundColor = COLOR_PRIMARY,
              rippleColor = COLOR_PRIMARY_DARK,
              cornerRadius = "6dp",
              padding = "0dp",
              textSize = "12sp",
              allCaps = false,
              gravity = "center"
            }
          },
          {
            Space,
            layout_width = "match_parent",
            layout_height = "4dp"
          },
          {
            LinearLayout,
            orientation = "horizontal",
            layout_width = "match_parent",
            layout_height = "wrap_content",
            gravity = "center",
            {
              MaterialButton,
              id = "btnSearch",
              text = "搜索音乐",
              layout_width = "0dp",
              layout_height = "wrap_content",
              layout_weight = "1",
              layout_marginRight = "8dp",
              textColor = COLOR_ON_PRIMARY,
              backgroundColor = COLOR_PRIMARY,
              rippleColor = COLOR_PRIMARY_DARK,
              cornerRadius = "12dp",
              padding = "8dp",
              textSize = "14sp",
              allCaps = false
            },
            {
              MaterialButton,
              id = "btnImport",
              text = "导入歌单",
              layout_width = "0dp",
              layout_height = "wrap_content",
              layout_weight = "1",
              textColor = COLOR_ON_PRIMARY,
              backgroundColor = COLOR_PRIMARY,
              rippleColor = COLOR_PRIMARY_DARK,
              cornerRadius = "12dp",
              padding = "8dp",
              textSize = "14sp",
              allCaps = false
            }
          }
        }
      },
      {
        MaterialCardView,
        id = "listLayout",
        layout_width = "match_parent",
        layout_height = "0dp",
        layout_weight = "1",
        cardBackgroundColor = COLOR_CARD_BG,
        strokeColor = COLOR_BORDER,
        strokeWidth = "1dp",
        radius = "12dp",
        elevation = "0dp",
        layout_marginBottom = "8dp",
        {
          LinearLayout,
          orientation = "vertical",
          layout_width = "match_parent",
          layout_height = "match_parent",
          padding = "8dp",
          {
            TextView,
            id = "tvListTitle",
            text = "搜索结果",
            textColor = COLOR_TEXT,
            textSize = "16sp",
            typeface = Typeface.DEFAULT_BOLD,
            padding = "8dp",
            gravity = "center"
          },
          {
            ListView,
            id = "lvSongs",
            layout_width = "match_parent",
            layout_height = "match_parent",
            dividerHeight = "0dp",
            fastScrollEnabled = true,
            padding = "0dp"
          }
        }
      },
      {
        MaterialCardView,
        id = "progressLayout",
        layout_width = "match_parent",
        layout_height = "wrap_content",
        cardBackgroundColor = COLOR_CARD_BG,
        strokeColor = COLOR_BORDER,
        strokeWidth = "1dp",
        radius = "12dp",
        elevation = "0dp",
        layout_marginBottom = "8dp",
        {
          LinearLayout,
          orientation = "vertical",
          layout_width = "match_parent",
          layout_height = "wrap_content",
          padding = "12dp",
          {
            ProgressBar,
            id = "pbSong",
            style = "?android:attr/progressBarStyleHorizontal",
            layout_width = "match_parent",
            layout_height = "16dp",
            max = 1000,
            progress = 0,
            indeterminate = false,
            progressDrawable = createProgressDrawable()
          },
          {
            Space,
            layout_width = "match_parent",
            layout_height = "4dp"
          },
          {
            LinearLayout,
            orientation = "horizontal",
            layout_width = "match_parent",
            layout_height = "wrap_content",
            gravity = "center_vertical",
            {
              TextView,
              id = "tvCurrentTime",
              text = "00:00",
              textColor = COLOR_TEXT,
              textSize = "12sp",
              layout_width = "wrap_content",
              layout_height = "wrap_content",
              layout_weight = "1"
            },
            {
              TextView,
              id = "tvTotalTime",
              text = "00:00",
              textColor = COLOR_TEXT,
              textSize = "12sp",
              layout_width = "wrap_content",
              layout_height = "wrap_content",
              gravity = "right"
            },
            {
              ImageButton,
              id = "btnLoop",
              layout_width = "24dp",
              layout_height = "24dp",
              background = nil,
              backgroundColor = Color.TRANSPARENT,
              scaleType = "fitCenter",
              padding = "4dp"
            }
          }
        }
      },
      {
        MaterialCardView,
        id = "controlLayout",
        layout_width = "match_parent",
        layout_height = "wrap_content",
        cardBackgroundColor = COLOR_CARD_BG,
        strokeColor = COLOR_BORDER,
        strokeWidth = "1dp",
        radius = "12dp",
        elevation = "0dp",
        {
          LinearLayout,
          orientation = "vertical",
          layout_width = "match_parent",
          layout_height = "wrap_content",
          padding = "12dp",
          {
            MaterialButton,
            id = "btnFloat",
            text = "显示悬浮窗",
            layout_width = "match_parent",
            layout_height = "wrap_content",
            textColor = COLOR_ON_PRIMARY,
            backgroundColor = COLOR_PRIMARY,
            rippleColor = COLOR_PRIMARY_DARK,
            cornerRadius = "12dp",
            padding = "12dp",
            textSize = "16sp",
            allCaps = false
          },
          {
            Space,
            layout_width = "match_parent",
            layout_height = "4dp"
          },
          {
            MaterialButton,
            id = "btnSettings",
            text = "设置",
            layout_width = "match_parent",
            layout_height = "wrap_content",
            textColor = COLOR_ON_PRIMARY,
            backgroundColor = COLOR_PRIMARY,
            rippleColor = COLOR_PRIMARY_DARK,
            cornerRadius = "12dp",
            padding = "12dp",
            textSize = "16sp",
            allCaps = false
          },
          {
            Space,
            layout_width = "match_parent",
            layout_height = "4dp"
          },
          {
            LinearLayout,
            orientation = "horizontal",
            layout_width = "match_parent",
            layout_height= "wrap_content",
            gravity = "center",
            {
              MaterialButton,
              id = "btnPlay",
              text = "播放",
              layout_width = "0dp",
              layout_height= "48dp",
              layout_weight= "1",
              layout_marginRight = "8dp",
              textColor = COLOR_ON_PRIMARY,
              backgroundColor = COLOR_PRIMARY,
              rippleColor = COLOR_PRIMARY_DARK,
              cornerRadius = "12dp",
              textSize = "16sp"
            },
            {
              MaterialButton,
              id = "btnFavorites",
              text = "收藏列表",
              layout_width = "0dp",
              layout_height= "48dp",
              layout_weight= "1",
              textColor = COLOR_ON_PRIMARY,
              backgroundColor = COLOR_PRIMARY,
              rippleColor = COLOR_PRIMARY_DARK,
              cornerRadius = "12dp",
              textSize = "16sp"
            }
          }
        }
      },
      {
        Space,
        layout_width = "match_parent",
        layout_height = "8dp"
      },
      {
        TextView,
        id = "tvStatus",
        text = "准备就绪",
        layout_width = "match_parent",
        layout_height = "wrap_content",
        gravity = "center",
        textColor = COLOR_TEXT,
        textSize = "14sp"
      }
    },
    {
        ImageButton,
        layout_width = "120dp",
        layout_height = "80dp",
        layout_alignParentRight = "true",
        layout_marginTop = "5dp",
        layout_marginRight = "8dp",
        src = "bluepng/blueAITP.png",
        background = "#00000000",
        id = "blueAI",
        scaleType = "fitCenter",
        onClick = function()--这样调用是因为所有调用MIUI及以上都会出现无反应的情况,所以改为在布局里绑定
        activity.newActivity("blueAI")
        end
    }
  }
end

activity.setContentView(loadlayout(createMainUI()))
applyBackground()
  
if isLooping then
  btnLoop.setImageBitmap(loadbitmap("kyxh.png"))
else
  btnLoop.setImageBitmap(loadbitmap("gbzt.png"))
end



btnLoop.onClick = function()
  toggleLooping()
end


local historyPrefs = activity.getSharedPreferences("search_history", Context.MODE_PRIVATE)
local searchHistory = {}

local function loadSearchHistory()
  local historyJson = historyPrefs.getString("history", "[]")
  searchHistory = json.decode(historyJson) or {}
end

local function saveSearchHistory()
  historyPrefs.edit().putString("history", json.encode(searchHistory)).apply()
end

local function addToSearchHistory(keyword)
  for i = #searchHistory, 1, -1 do
    if searchHistory[i] == keyword then
      table.remove(searchHistory, i)
    end
  end
  table.insert(searchHistory, 1, keyword)
  saveSearchHistory()
end

local function showBackgroundSettings()
  local dialogLayout = {
    LinearLayout,
    id = "bgDialogRoot",
    orientation = "vertical",
    layout_width = "match_parent",
    layout_height = "wrap_content",
    padding = "24dp",
    background = createBorderDrawable(COLOR_CARD_BG, COLOR_BORDER, 1, 24),
    elevation = "8dp",
    {
      TextView,
      text = "自定义背景设置",
      textColor = COLOR_TEXT,
      textSize = "20sp",
      typeface = Typeface.DEFAULT_BOLD,
      gravity = "center",
      paddingBottom = "16dp"
    },
    {
      LinearLayout,
      orientation = "horizontal",
      layout_width = "match_parent",
      layout_height = "wrap_content",
      gravity = "center_vertical",
      {
        TextView,
        text = "启用自定义背景",
        textColor = COLOR_TEXT,
        textSize = "16sp",
        layout_weight = 1
      },
      {
        MaterialSwitch,
        id = "swBgEnabled",
        layout_width = "wrap_content",
        layout_height = "wrap_content",
        checked = isCustomBgEnabled,
        thumbTint = ColorStateList({
          {android.R.attr.state_checked},
          {}
        }, {
          COLOR_PRIMARY,
          Color.parseColor("#BDBDBD")
        }),
        trackTint = ColorStateList({
          {android.R.attr.state_checked},
          {}
        }, {
          Color.argb(0x4D, Color.red(COLOR_PRIMARY), Color.green(COLOR_PRIMARY), Color.blue(COLOR_PRIMARY)),
          Color.parseColor("#4D9E9E9E")
        })
      }
    },
    {
      View,
      layout_width = "match_parent",
      layout_height = "2dp",
      background = createRoundRectDrawable(COLOR_BORDER, 8),
      layout_marginTop = "8dp",
      layout_marginBottom = "8dp"
    },
    {
      LinearLayout,
      orientation = "horizontal",
      layout_width = "match_parent",
      layout_height = "wrap_content",
      gravity = "center_vertical",
      {
        TextView,
        text = "启用模糊效果",
        textColor = COLOR_TEXT,
        textSize = "16sp",
        layout_weight = 1
      },
      {
        MaterialSwitch,
        id = "swBlurEnabled",
        layout_width = "wrap_content",
        layout_height = "wrap_content",
        checked = isBlurEnabled,
        enabled = isCustomBgEnabled,
        thumbTint = ColorStateList({
          {android.R.attr.state_checked},
          {}
        }, {
          COLOR_PRIMARY,
          Color.parseColor("#BDBDBD")
        }),
        trackTint = ColorStateList({
          {android.R.attr.state_checked},
          {}
        }, {
          Color.argb(0x4D, Color.red(COLOR_PRIMARY), Color.green(COLOR_PRIMARY), Color.blue(COLOR_PRIMARY)),
          Color.parseColor("#4D9E9E9E")
        })
      }
    },
    {
      View,
      layout_width = "match_parent",
      layout_height = "2dp",
      background = createRoundRectDrawable(COLOR_BORDER, 8),
      layout_marginTop = "8dp",
      layout_marginBottom = "8dp"
    },
    {
      LinearLayout,
      orientation = "vertical",
      layout_width = "match_parent",
      layout_height = "wrap_content",
      gravity = "center_vertical",
      layout_marginTop = "8dp",
      enabled = isCustomBgEnabled and isBlurEnabled,
      {
        TextView,
        text = "模糊程度",
        textColor = COLOR_TEXT,
        textSize = "16sp",
        layout_marginBottom = "8dp"
      },
      {
        Slider,
        id = "sliderBlurRadius",
        layout_width = "match_parent",
        layout_height = "wrap_content",
        valueFrom = 0,
        valueTo = 25,
        value = blurRadius,
        enabled = isCustomBgEnabled and isBlurEnabled,
        thumbTint = ColorStateList({}, {COLOR_PRIMARY}),
        trackColorInactive = Color.parseColor("#BDBDBD"),
        trackColorActive = COLOR_PRIMARY,
        haloColor = Color.argb(0x33, Color.red(COLOR_PRIMARY), Color.green(COLOR_PRIMARY), Color.blue(COLOR_PRIMARY)),
        layout_marginBottom = "16dp"
      }
    },
    {
      View,
      layout_width = "match_parent",
      layout_height = "2dp",
      background = createRoundRectDrawable(COLOR_BORDER, 8),
      layout_marginTop = "8dp",
      layout_marginBottom = "8dp"
    },
    {
      LinearLayout,
      orientation = "vertical",
      layout_width = "match_parent",
      layout_height = "wrap_content",
      gravity = "center_vertical",
      enabled = isCustomBgEnabled,
      {
        TextView,
        text = "卡片透明度",
        textColor = COLOR_TEXT,
        textSize = "16sp",
        layout_marginBottom = "8dp"
      },
      {
        Slider,
        id = "sliderCardAlpha",
        layout_width = "match_parent",
        layout_height = "wrap_content",
        valueFrom = 0,
        valueTo = 100,
        value = cardAlpha,
        enabled = isCustomBgEnabled,
        thumbTint = ColorStateList({}, {COLOR_PRIMARY}),
        trackColorInactive = Color.parseColor("#BDBDBD"),
        trackColorActive = COLOR_PRIMARY,
        haloColor = Color.argb(0x33, Color.red(COLOR_PRIMARY), Color.green(COLOR_PRIMARY), Color.blue(COLOR_PRIMARY)),
        layout_marginBottom = "16dp"
      }
    },
    {
      View,
      layout_width = "match_parent",
      layout_height = "2dp",
      background = createRoundRectDrawable(COLOR_BORDER, 8),
      layout_marginTop = "8dp",
      layout_marginBottom = "8dp"
    },
    {
      MaterialButton,
      id = "btnSelectBg",
      text = "选择背景图片",
      layout_width = "match_parent",
      layout_height = "48dp",
      layout_marginTop = "8dp",
      textColor = Color.WHITE,
      backgroundColor = COLOR_PRIMARY,
      rippleColor = COLOR_PRIMARY_DARK,
      cornerRadius = "8dp",
      enabled = isCustomBgEnabled,
      icon = "ic_image_white_24dp",
      iconGravity = "textStart",
      iconPadding = "8dp",
      iconTint = Color.WHITE
    },
    {
      MaterialButton,
      id = "btnClearBg",
      text = "清除背景图片",
      layout_width = "match_parent",
      layout_height = "48dp",
      layout_marginTop = "8dp",
      textColor = Color.WHITE,
      backgroundColor = COLOR_ERROR,
      rippleColor = Color.parseColor("#D32F2F"),
      cornerRadius = "8dp",
      enabled = isCustomBgEnabled and bgImagePath ~= "",
      icon = "ic_delete_white_24dp",
      iconGravity = "textStart",
      iconPadding = "8dp",
      iconTint = Color.WHITE
    },
    {
      LinearLayout,
      orientation = "horizontal",
      layout_width = "match_parent",
      layout_height = "wrap_content",
      gravity = "center",
      layout_marginTop = "16dp",
      {
        MaterialButton,
        id = "btnCancelBg",
        text = "取消",
        layout_width = "0dp",
        layout_height = "48dp",
        layout_weight = 1,
        layout_marginRight = "8dp",
        textColor = COLOR_TEXT,
        backgroundColor = COLOR_SURFACE_VARIANT,
        rippleColor = COLOR_BORDER,
        cornerRadius = "8dp",
        icon = "ic_close_black_24dp",
        iconGravity = "textStart",
        iconPadding = "8dp",
        iconTint = COLOR_TEXT
      },
      {
        MaterialButton,
        id = "btnSaveBg",
        text = "保存",
        layout_width = "0dp",
        layout_height = "48dp",
        layout_weight = 1,
        textColor = Color.WHITE,
        backgroundColor = COLOR_PRIMARY,
        rippleColor = COLOR_PRIMARY_DARK,
        cornerRadius = "8dp",
        icon = "ic_save_white_24dp",
        iconGravity = "textStart",
        iconPadding = "8dp",
        iconTint = Color.WHITE
      }
    }
  }

  local dialog = AlertDialog.Builder(activity)
  .setView(loadlayout(dialogLayout))
  .setCancelable(false)
  .show()

  local window = dialog.getWindow()
  window.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
  window.setDimAmount(0.5)

  bgDialogRoot.setAlpha(0)
  bgDialogRoot.setTranslationY(dp2px(20))
  bgDialogRoot.animate()
  .alpha(1)
  .translationY(0)
  .setDuration(500)
  .setInterpolator(DecelerateInterpolator())
  .start()

  swBgEnabled.setOnCheckedChangeListener({
    onCheckedChanged = function(view, isChecked)
      swBlurEnabled.setEnabled(isChecked)
      sliderBlurRadius.setEnabled(isChecked and swBlurEnabled.isChecked())
      btnSelectBg.setEnabled(isChecked)
      btnClearBg.setEnabled(isChecked and bgImagePath ~= "")
      sliderCardAlpha.setEnabled(isChecked)
    end
  })

  swBlurEnabled.setOnCheckedChangeListener({
    onCheckedChanged = function(view, isChecked)
      sliderBlurRadius.setEnabled(isChecked)
    end
  })

  btnSelectBg.onClick = function()
    local intent = Intent(Intent.ACTION_PICK)
    intent.setType("image/*")
    activity.startActivityForResult(intent, 100)
  end

  btnClearBg.onClick = function()
    bgImagePath = ""
    btnClearBg.setEnabled(false)
    Toast.makeText(activity, "已清除背景图片", Toast.LENGTH_SHORT).show()
  end

  btnCancelBg.onClick = function()
    bgDialogRoot.animate()
    .alpha(0)
    .translationY(dp2px(20))
    .setDuration(400)
    .withEndAction(Runnable({
      run = function()
        dialog.dismiss()
      end
    }))
    .start()
  end

  btnSaveBg.onClick = function()
    isCustomBgEnabled = swBgEnabled.isChecked()
    isBlurEnabled = swBlurEnabled.isChecked()
    cardAlpha = math.floor(sliderCardAlpha.getValue())
    blurRadius = math.floor(sliderBlurRadius.getValue())

    local editor = bgPrefs.edit()
    editor.putBoolean("enabled", isCustomBgEnabled)
    editor.putBoolean("blur", isBlurEnabled)
    editor.putString("path", bgImagePath)
    editor.putInt("card_alpha", cardAlpha)
    editor.putInt("blur_radius", blurRadius)
    editor.apply()

    -- 预加载背景
    loadAndCacheBackground()
    
    bgDialogRoot.animate()
    .alpha(0)
    .translationY(dp2px(20))
    .setDuration(400)
    .withEndAction(Runnable({
      run = function()
        dialog.dismiss()
        applyBackground()
        Toast.makeText(activity, "背景设置已保存", Toast.LENGTH_SHORT).show()
      end
    }))
    .start()
  end
end

local function showHistoryDialog()
  if #searchHistory == 0 then
    Toast.makeText(activity, "暂无历史搜索记录", Toast.LENGTH_SHORT).show()
    return
  end
  local dialogLayout = {
    LinearLayout,
    orientation = "vertical",
    layout_width = "match_parent",
    layout_height = "wrap_content",
    padding = "16dp",
    background = createBorderDrawable(COLOR_CARD_BG, COLOR_BORDER, 1, 16),
    {
      TextView,
      text = "历史搜索",
      textColor = COLOR_TEXT,
      textSize = "18sp",
      typeface = Typeface.DEFAULT_BOLD,
      paddingBottom = "16dp"
    },
    {
      ListView,
      id = "historyList",
      layout_width = "match_parent",
      layout_height = "0dp",
      layout_weight = "1",
      dividerHeight = "1dp",
      divider = createRoundRectDrawable(COLOR_SURFACE_VARIANT, 0),
      background = createRoundRectDrawable(COLOR_SURFACE_VARIANT, 12),
      padding = "8dp"
    },
    {
      LinearLayout,
      orientation = "horizontal",
      layout_width = "match_parent",
      layout_height = "wrap_content",
      gravity = "center",
      layout_marginTop = "16dp",
      {
        MaterialButton,
        id = "btnClear",
        text = "清空历史",
        layout_width = "0dp",
        layout_height = "48dp",
        layout_weight = 1,
        layout_marginRight = "8dp",
        textColor = Color.WHITE,
        backgroundColor = COLOR_ERROR,
        rippleColor = Color.parseColor("#D32F2F"),
        cornerRadius = "8dp",
        padding = "8dp",
        textSize = "14sp"
      },
      {
        MaterialButton,
        id = "btnClose",
        text = "关闭",
        layout_width = "0dp",
        layout_height = "48dp",
        layout_weight = 1,
        textColor = Color.WHITE,
        backgroundColor = COLOR_PRIMARY,
        rippleColor = COLOR_PRIMARY_DARK,
        cornerRadius = "8dp",
        padding = "8dp",
        textSize = "14sp"
      }
    }
  }
  local dialogView = loadlayout(dialogLayout)
  local historyAdapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1)
  for _, keyword in ipairs(searchHistory) do
    historyAdapter.add(keyword)
  end
  historyList.adapter = historyAdapter
  local defaultItemBg = createRoundRectDrawable(COLOR_CARD_BG, 8)
  local pressedItemBg = createRoundRectDrawable(Color.parseColor("#E0E0E0"), 8)
  local itemSelector = StateListDrawable()
  itemSelector.addState({android.R.attr.state_pressed}, pressedItemBg)
  itemSelector.addState({}, defaultItemBg)
  historyList.setSelector(itemSelector)
  historyList.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick = function(parent, view, position, id)
      local selected = searchHistory[position + 1]
      if selected then
        etSearch.setText(selected)
        searchMusic(selected)
        dialog.dismiss()
      end
    end
  })
  local dialog = AlertDialog.Builder(activity)
  .setView(dialogView)
  .setCancelable(true)
  .show()
  local window = dialog.getWindow()
  window.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
  local displayMetrics = DisplayMetrics()
  activity.getWindowManager().getDefaultDisplay().getMetrics(displayMetrics)
  local screenWidth = displayMetrics.widthPixels
  window.setLayout(screenWidth - dp2px(48), WindowManager.LayoutParams.WRAP_CONTENT)
  btnClear.onClick = function()
    searchHistory = {}
    saveSearchHistory()
    historyAdapter.clear()
    Toast.makeText(activity, "历史记录已清空", Toast.LENGTH_SHORT).show()
    dialog.dismiss()
  end
  btnClose.onClick = function()
    dialog.dismiss()
  end
end

loadSearchHistory()

local imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
local adapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1)
lvSongs.adapter = adapter
lvSongs.setPadding(0, dp2px(8), 0, dp2px(8))
lvSongs.setDividerHeight(0)
lvSongs.setCacheColorHint(0x00000000)
local defaultMainBg = createRoundRectDrawable(COLOR_CARD_BG, 12)
local pressedMainBg = createRoundRectDrawable(Color.parseColor("#BBDEFB"), 12)
local mainSelector = StateListDrawable()
mainSelector.addState({android.R.attr.state_pressed}, pressedMainBg)
mainSelector.addState({}, defaultMainBg)
lvSongs.setSelector(mainSelector)

local function createSongMenu(entry, isFavorite)
  local menuLayout = {
    LinearLayout,
    id = "songMenuRoot",
    orientation = "vertical",
    layout_width = "match_parent",
    layout_height = "wrap_content",
    background = createBorderDrawable(COLOR_CARD_BG, COLOR_BORDER, 1, 16),
    padding = "8dp",
    {
      TextView,
      text = "歌曲操作",
      textColor = COLOR_TEXT,
      textSize = "16sp",
      typeface = Typeface.DEFAULT_BOLD,
      gravity = "center",
      padding = "8dp"
    },
    {
      View,
      layout_width = "match_parent",
      layout_height = "2dp",
      background = createRoundRectDrawable(COLOR_BORDER, 8),
      layout_marginTop = "4dp",
      layout_marginBottom = "4dp"
    },
    {
      LinearLayout,
      orientation = "horizontal",
      layout_width = "match_parent",
      layout_height = "wrap_content",
      gravity = "center",
      {
        MaterialButton,
        id = "btnSaveToFloat",
        text = "保存到悬浮窗",
        layout_width = "0dp",
        layout_height = "40dp",
        layout_weight = "1",
        layout_margin = "4dp",
        textColor = COLOR_ON_PRIMARY,
        backgroundColor = COLOR_PRIMARY,
        rippleColor = COLOR_PRIMARY_DARK,
        cornerRadius = "8dp",
        textSize = "14sp",
        allCaps = false
      },
      {
        MaterialButton,
        id = isFavorite and "btnRemoveFromFavorites" or "btnAddToFavorites",
        text = isFavorite and "移除收藏" or "收藏到列表",
        layout_width = "0dp",
        layout_height = "40dp",
        layout_weight = "1",
        layout_margin = "4dp",
        textColor = COLOR_ON_PRIMARY,
        backgroundColor = COLOR_PRIMARY,
        rippleColor = COLOR_PRIMARY_DARK,
        cornerRadius = "8dp",
        textSize = "14sp",
        allCaps = false
      }
    }
  }
  return loadlayout(menuLayout)
end

local function showSongMenu(entry, touchX, touchY, isFavorite)
  local popupWidth = dp2px(280)
  local popupHeight = dp2px(120)

  -- 确保弹出位置在屏幕内
  local x = math.max(dp2px(16), math.min(touchX - popupWidth / 2, screenWidth - popupWidth - dp2px(16)))
  local y = math.max(dp2px(16), math.min(touchY - popupHeight / 2, screenHeight - popupHeight - dp2px(16)))

  local popupView = createSongMenu(entry, isFavorite)
  local popup = PopupWindow(activity)
  popup.setContentView(popupView)
  popup.setWidth(popupWidth)
  popup.setHeight(popupHeight)
  popup.setFocusable(true)
  popup.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
  popup.setOutsideTouchable(true)
  popup.setAnimationStyle(android.R.style.Animation_Dialog)

  local firstX, firstY, initX, initY
  popupView.setOnTouchListener(function(v, event)
    local action = event.getAction()
    if action == MotionEvent.ACTION_DOWN then
      firstX = event.getRawX()
      firstY = event.getRawY()
      initX = x
      initY = y
      return true
    elseif action == MotionEvent.ACTION_MOVE then
      local dx = event.getRawX() - firstX
      local dy = event.getRawY() - firstY
      x = initX + dx
      y = initY + dy
      popup.update(x, y, -1, -1)
      return true
    end
    return false
  end)

  popup.showAtLocation(activity.getDecorView(), Gravity.NO_GRAVITY, x, y)

  btnSaveToFloat.onClick = function()
    popup.dismiss()
    local exists = false
    local saved = loadSavedSongs()
    for _, v in ipairs(saved) do
      if v.id == entry.id then
        exists = true
        break
      end
    end
    if exists then
      Toast.makeText(activity, "该歌曲已存在于悬浮窗列表", Toast.LENGTH_SHORT).show()
      return
    end

    local filename = entry.name:gsub("[^%w%.%-%_ ]", "") .. ".mp3"
    filename = filename:gsub(" ", "_")
    local localPath = musicDir .. "/" .. filename

    tvStatus.text = "正在下载: " .. entry.name
    Http.download(entry.url, localPath, function(code, path)
      activity.runOnUiThread(function()
        if code == 200 then
          entry.localPath = path
          insertSongToDB(entry)
          Toast.makeText(activity, "✔ 已添加到悬浮窗: " .. entry.name .. " - " .. entry.artist, Toast.LENGTH_SHORT).show()
          tvStatus.text = "下载并添加完成: " .. entry.name
        else
          tvStatus.text = "下载失败,是否给予了储存权限？，状态码: " .. code
        end
      end)
    end)
  end

  if isFavorite then
    btnRemoveFromFavorites.onClick = function()
      popup.dismiss()
      removeFromFavorites(entry.id)
      refreshFavoritesList()
      Toast.makeText(activity, "✔ 已从收藏列表移除: " .. entry.name .. " - " .. entry.artist, Toast.LENGTH_SHORT).show()
    end
  else
    btnAddToFavorites.onClick = function()
      popup.dismiss()
      local exists = false
      for _, v in ipairs(favorites) do
        if v.id == entry.id then
          exists = true
          break
        end
      end
      if not exists then
        addToFavorites(entry)
        table.insert(favorites, entry)
        Toast.makeText(activity, "✔ 已添加到收藏列表: " .. entry.name .. " - " .. entry.artist, Toast.LENGTH_SHORT).show()
      else
        Toast.makeText(activity, "该歌曲已在收藏列表中", Toast.LENGTH_SHORT).show()
      end
    end
  end
end

local function extractPlaylistId(url)
  -- 支持多种格式的网易云歌单链接
  local patterns = {
    "playlist%?id=(%d+)",
    "playlist/(%d+)",
    "playlist%3Fid%3D(%d+)",
    "playlist/%3Fid%3D(%d+)",
    "id=(%d+)",
    "id%3D(%d+)"
  }
  
  for _, pattern in ipairs(patterns) do
    local id = string.match(url, pattern)
    if id then
      return id
    end
  end
  return nil
end

local function importNeteasePlaylist()
  local dialogLayout = {
    LinearLayout,
    id = "dialogRoot",
    orientation = "vertical",
    layout_width = "match_parent",
    layout_height = "wrap_content",
    background = createBorderDrawable(COLOR_CARD_BG, COLOR_BORDER, 1, 24),
    padding = "16dp",
    {
      TextView,
      text = "导入网易云歌单",
      textColor = COLOR_TEXT,
      textSize = "18sp",
      typeface = Typeface.DEFAULT_BOLD,
      paddingBottom = "16dp",
      gravity = "center"
    },
    {
      TextInputLayout,
      layout_width = "match_parent",
      layout_height = "wrap_content",
      hint = "粘贴网易云歌单分享链接",
      hintTextColor = COLOR_ON_SURFACE_VAR,
      boxBackgroundMode = "outline",
      boxBackgroundColor = COLOR_CARD_BG,
      boxStrokeColor = COLOR_BORDER,
      boxCornerRadius = "8dp",
      {
        TextInputEditText,
        id = "etPlaylistUrl",
        textColor = COLOR_TEXT,
        layout_width = "match_parent",
        layout_height = "wrap_content",
        textSize = "14sp"
      }
    },
    {
      TextView,
      id = "tvImportHelp",
      text = "如何获取歌单链接？\n1. 打开网易云音乐\n2. 找到要分享的歌单\n3. 点击分享按钮\n4. 选择复制链接",
      textColor = COLOR_TEXT,
      textSize = "12sp",
      layout_marginTop = "12dp",
      layout_marginBottom = "12dp"
    },
    {
      MaterialCardView,
      layout_width = "match_parent",
      layout_height = "wrap_content",
      cardBackgroundColor = COLOR_SURFACE_VARIANT,
      strokeColor = COLOR_BORDER,
      strokeWidth = "1dp",
      radius = "12dp",
      elevation = "0dp",
      {
        RadioGroup,
        id = "rgImportTarget",
        orientation = "vertical",
        layout_width = "match_parent",
        layout_height = "wrap_content",
        padding = "8dp",
        {
          MaterialRadioButton,
          id = "rbToFavorites",
          text = "导入到收藏列表",
          textColor = COLOR_TEXT,
          textSize = "14sp",
          layout_width = "match_parent",
          layout_height = "wrap_content",
          checked = true,
          buttonTint = ColorStateList({
            {android.R.attr.state_checked},
            {}
          }, {
            COLOR_PRIMARY,
            Color.parseColor("#757575")
          }),
          rippleColor = COLOR_PRIMARY_DARK,
          layout_marginBottom = "8dp"
        },
        {
          MaterialRadioButton,
          id = "rbToFloat",
          text = "导入到悬浮窗",
          textColor = COLOR_TEXT,
          textSize = "14sp",
          layout_width = "match_parent",
          layout_height = "wrap_content",
          buttonTint = ColorStateList({
            {android.R.attr.state_checked},
            {}
          }, {
            COLOR_PRIMARY,
            Color.parseColor("#757575")
          }),
          rippleColor = COLOR_PRIMARY_DARK
        }
      }
    },
    {
      LinearLayout,
      orientation = "horizontal",
      layout_width = "match_parent",
      layout_height = "wrap_content",
      gravity = "center",
      layout_marginTop = "16dp",
      {
        MaterialButton,
        id = "btnCancelImport",
        text = "取消",
        layout_width = "0dp",
        layout_height = "48dp",
        layout_weight = 1,
        layout_marginRight = "8dp",
        textColor = Color.WHITE,
        backgroundColor = COLOR_ERROR,
        rippleColor = Color.parseColor("#D32F2F"),
        cornerRadius = "8dp",
        padding = "8dp",
        textSize = "14sp"
      },
      {
        MaterialButton,
        id = "btnConfirmImport",
        text = "导入",
        layout_width = "0dp",
        layout_height = "48dp",
        layout_weight = 1,
        textColor = Color.WHITE,
        backgroundColor = COLOR_PRIMARY,
        rippleColor = COLOR_PRIMARY_DARK,
        cornerRadius = "8dp",
        padding = "8dp",
        textSize = "14sp"
      }
    }
  }

  local dialogView = loadlayout(dialogLayout)
  local dialog = AlertDialog.Builder(activity)
  .setView(dialogView)
  .setCancelable(true)
  .show()

  dialogRoot.setAlpha(0)
  dialogRoot.setTranslationY(dp2px(20))
  dialogRoot.animate()
  .alpha(1)
  .translationY(0)
  .setDuration(500)
  .setInterpolator(DecelerateInterpolator())
  .start()

  local window = dialog.getWindow()
  window.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
  window.setDimAmount(0.5)

  btnCancelImport.onClick = function()
    dialogRoot.animate()
    .alpha(0)
    .translationY(dp2px(20))
    .setDuration(400)
    .withEndAction(Runnable({
      run = function()
        dialog.dismiss()
      end
    }))
    .start()
  end

  btnConfirmImport.onClick = function()
    local url = tostring(etPlaylistUrl.text)
    if url == "" then
      Toast.makeText(activity, "请输入歌单链接", Toast.LENGTH_SHORT).show()
      return
    end

    local playlistId = extractPlaylistId(url)
    if not playlistId then
      Toast.makeText(activity, "无效的歌单链接，请确保是网易云音乐的歌单链接", Toast.LENGTH_SHORT).show()
      return
    end

    dialogRoot.animate()
    .alpha(0)
    .translationY(dp2px(20))
    .setDuration(400)
    .withEndAction(Runnable({
      run = function()
        dialog.dismiss()
        local progressLayout = {
          LinearLayout,
          id = "progressRoot",
          orientation = "vertical",
          layout_width = "300dp",
          layout_height = "wrap_content",
          padding = "24dp",
          background = createBorderDrawable(COLOR_CARD_BG, COLOR_BORDER, 1, 24),
          {
            TextView,
            text = "导入歌单中...",
            textColor = COLOR_TEXT,
            textSize = "18sp",
            gravity = "center",
            paddingBottom = "16dp"
          },
          {
            ProgressBar,
            id = "pbImport",
            style = "?android:attr/progressBarStyleHorizontal",
            layout_width = "match_parent",
            layout_height = "16dp",
            progress = 0,
            progressDrawable = createProgressDrawable(),
            layout_marginTop = "8dp",
            layout_marginBottom = "16dp"
          },
          {
            TextView,
            id = "tvImportStatus",
            text = "准备导入...",
            textColor = COLOR_TEXT,
            textSize = "14sp",
            gravity = "center",
            layout_marginBottom = "16dp"
          },
          {
            MaterialButton,
            id = "btnCancelImport",
            text = "取消导入",
            layout_width = "match_parent",
            layout_height = "48dp",
            textColor = Color.WHITE,
            backgroundColor = COLOR_ERROR,
            rippleColor = Color.parseColor("#D32F2F"),
            cornerRadius = "12dp",
            textSize = "16sp"
          }
        }

        local progressView = loadlayout(progressLayout)
        local progressDialog = AlertDialog.Builder(activity)
        .setView(progressView)
        .setCancelable(false)
        .show()

        local progressWindow = progressDialog.getWindow()
        progressWindow.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
        progressWindow.setDimAmount(0.5)

        progressRoot.setAlpha(0)
        progressRoot.setTranslationY(dp2px(20))
        progressRoot.animate()
        .alpha(1)
        .translationY(0)
        .setDuration(500)
        .setInterpolator(DecelerateInterpolator())
        .start()

        btnCancelImport.onClick = function()
          progressRoot.animate()
          .alpha(0)
          .translationY(dp2px(20))
          .setDuration(400)
          .withEndAction(Runnable({
            run = function()
              progressDialog.dismiss()
              Toast.makeText(activity, "导入已取消", Toast.LENGTH_SHORT).show()
            end
          }))
          .start()
        end

        local headers = {
          ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
          ["Referer"] = "http://music.163.com/",
          ["Cookie"] = "appver=2.0.2"
        }

        Http.get("https://music.163.com/api/v3/playlist/detail?id=" .. playlistId .. "&limit=60", headers, function(code, content)
          activity.runOnUiThread(function()
            if code == 200 then
              local ok, data = pcall(json.decode, content)
            if ok and data and data.playlist and data.playlist.tracks then
                local importedCount = 0
                local failedCount = 0
                local totalCount = #data.playlist.tracks
                pbImport.setMax(totalCount)

                local animator = ObjectAnimator.ofInt(pbImport, "progress", {0, totalCount})
                animator.setDuration(totalCount * 300)
                animator.setInterpolator(AccelerateInterpolator())

                local bounceAnimator = ObjectAnimator.ofFloat(pbImport, "translationY", {0, -dp2px(8), 0})
                bounceAnimator.setDuration(200)
                bounceAnimator.setInterpolator(BounceInterpolator())

                animator.addListener({
                  onAnimationEnd = function()
                    bounceAnimator.start()
                  end
                })

                animator.start()

                for i, track in ipairs(data.playlist.tracks) do
                  Handler().postDelayed(Runnable{
                    run = function()
                      activity.runOnUiThread(function()
                        tvImportStatus.text = string.format("正在导入歌曲 %d/%d", i, totalCount)
                      end)

                      local artists = ""
                      if track.ar then
                        for j, artist in ipairs(track.ar) do
                          if j > 1 then artists = artists .. ", " end
                          artists = artists .. artist.name
                        end
                       else
                        artists = "未知艺术家"
                      end

                      local entry = {
                        name = track.name or "未知歌曲",
                        artist = artists,
                        id = tostring(track.id or i),
                        url = "http://music.163.com/song/media/outer/url?id=" .. (track.id or "") .. ".mp3"
                      }

                      local exists = false
                      local success = true

                      if rbToFavorites.isChecked() then
                        for _, fav in ipairs(favorites) do
                          if fav.id == entry.id then
                            exists = true
                            break
                          end
                        end

                        if not exists then
                          addToFavorites(entry)
                          table.insert(favorites, entry)
                          importedCount = importedCount + 1
                        end
                      end

                      if rbToFloat.isChecked() then
                        exists = false
                        local saved = loadSavedSongs()
                        for _, v in ipairs(saved) do
                          if v.id == entry.id then
                            exists = true
                            break
                          end
                        end

                        if not exists then
                          local filename = entry.name:gsub("[^%w%.%-%_ ]", "") .. ".mp3"
                          filename = filename:gsub(" ", "_")
                          local localPath = musicDir .. "/" .. filename

                          Http.download(entry.url, localPath, function(dlCode, path)
                            if dlCode == 200 then
                              entry.localPath = path
                              insertSongToDB(entry)
                              importedCount = importedCount + 1
                             else
                              failedCount = failedCount + 1
                              activity.runOnUiThread(function()
                                tvImportStatus.text = string.format("导入失败: %s", entry.name)
                              end)
                            end
                          end)
                        end
                      end

                      activity.runOnUiThread(function()
                        pbImport.setProgress(i)
                      end)

                      if i == totalCount then
                        Handler().postDelayed(Runnable{
                          run = function()
                            bounceAnimator.start()

                            Handler().postDelayed(Runnable{
                              run = function()
                                progressRoot.animate()
                                .alpha(0)
                                .translationY(dp2px(20))
                                .setDuration(400)
                                .withEndAction(Runnable({
                                  run = function()
                                    progressDialog.dismiss()
                                    local successMsg = string.format("成功导入 %d 首歌曲", importedCount)
                                    if failedCount > 0 then
                                      successMsg = successMsg .. string.format(" (%d 首失败)", failedCount)
                                    end
                                    Toast.makeText(activity, successMsg, Toast.LENGTH_LONG).show()

                                    if currentListType == "favorites" then
                                      refreshFavoritesList()
                                    end
                                  end
                                }))
                                .start()
                              end
                            }, 500)
                          end
                        }, 300)
                      end
                    end
                  }, (i-1) * 300)
                end
               else
                local errMsg = "解析歌单数据失败"
                if not ok then
                  errMsg = "JSON解析错误: " .. tostring(data)
                 elseif not data then
                  errMsg = "API返回空数据"
                 elseif not data.playlist then
                  errMsg = "API返回格式错误"
                end

                progressRoot.animate()
                .alpha(0)
                .translationY(dp2px(20))
                .setDuration(400)
                .withEndAction(Runnable({
                  run = function()
                    progressDialog.dismiss()
                    Toast.makeText(activity, errMsg, Toast.LENGTH_SHORT).show()
                  end
                }))
                .start()
              end
             else
              progressRoot.animate()
              .alpha(0)
              .translationY(dp2px(20))
              .setDuration(400)
              .withEndAction(Runnable({
                run = function()
                  progressDialog.dismiss()
                  Toast.makeText(activity, "获取歌单失败，状态码: " .. code, Toast.LENGTH_SHORT).show()
                end
              }))
              .start()
            end
          end)
        end)
      end
    }))
    .start()
  end
end

local function searchMusic(keyword)
    if not keyword or keyword == "" then
        tvStatus.text = "请输入搜索关键词"
        return
    end
    addToSearchHistory(keyword)
    imm.hideSoftInputFromWindow(etSearch.getWindowToken(), 0)
    tvStatus.text = "正在搜索: " .. keyword
    
    -- 确保当前是搜索列表
    currentListType = "search"
    btnFavorites.text = "收藏列表"
    
    Http.get("http://music.163.com/api/search/get/web?s=" .. keyword .. "&type=1&limit=50", function(code, content)
        if code == 200 then
            local ok, data = pcall(json.decode, content)
            if ok and data and data.result and data.result.songs then
                searchResults = {}
                adapter.clear()
                lvSongs.setAlpha(0.0)
                lvSongs.animate().alpha(1.0).setDuration(600).start()
                for i, song in ipairs(data.result.songs) do
                    local artists = ""
                    for j, artist in ipairs(song.artists) do
                        if j > 1 then artists = artists .. ", " end
                        artists = artists .. artist.name
                    end
                    local entry = {
                        name = song.name,
                        artist = artists,
                        id = tostring(song.id),
                        url = "http://music.163.com/song/media/outer/url?id=" .. song.id .. ".mp3"
                    }
                    table.insert(searchResults, entry)
                    adapter.add(song.name .. "\n" .. artists)
                end
                lvSongs.setAdapter(adapter)
                tvListTitle.text = "搜索结果 (" .. #searchResults .. " 首)"
                tvStatus.text = "找到 " .. #searchResults .. " 首歌曲"
                

                lvSongs.setOnItemClickListener(AdapterView.OnItemClickListener{
                    onItemClick = function(parent, view, position, id)
                        local index = position + 1
                        if index <= #searchResults then
                            playMusic(searchResults[index])
                        end
                    end
                })
                
                lvSongs.setOnItemLongClickListener(AdapterView.OnItemLongClickListener{
                    onItemLongClick = function(parent, view, position, id)
                        local index = position + 1
                        if index <= #searchResults then
                            local entry = searchResults[index]
                            if lastTouchX and lastTouchY then
                                showSongMenu(entry, lastTouchX, lastTouchY, false)
                            else
                                local location = {0, 0}
                                view.getLocationOnScreen(location)
                                local x = location[1] + view.getWidth()/2
                                local y = location[2] + view.getHeight()/2
                                showSongMenu(entry, x, y, false)
                            end
                        end
                        return true
                    end
                })
            else
                tvStatus.text = "解析数据失败"
            end
        else
            tvStatus.text = "搜索失败，状态码: " .. code
        end
    end)
end

local xfqsongs = loadSavedSongs()
local favorites = loadFavorites()
local adapter_xfq = ArrayAdapter(activity, android.R.layout.simple_list_item_1)
local floatingWindow = nil
local floatingBall = nil
local wm = activity.getSystemService(Context.WINDOW_SERVICE)
local wmParams = WindowManager.LayoutParams()
local wmParamsBall = WindowManager.LayoutParams()
local isFloatingWindowOpen = false
local isFloatingBallVisible = false
local ballSizePx = dp2px(56)

local function createFloatingWindowLayout()
  local theme = themeColors[currentThemeIndex]
  
  local bgColor, borderColor
  if isFloatWindowTransparent then
    bgColor = Color.parseColor("#27FFFFFF")
    borderColor = Color.parseColor("#00000000")
  else
    bgColor = theme.CARD_BG
    borderColor = theme.BORDER
  end
  
  return {
    LinearLayout,
    id = "xfq_root",
    orientation = "vertical",
    layout_width = "280dp",
    layout_height = "wrap_content",
    background = createBorderDrawable(bgColor, borderColor, 1, 24),
    padding = "12dp",
    {
      TextView,
      id = "xfq_nowPlaying",
      text = "当前未播放",
      textColor = theme.TEXT_COLOR,
      textSize = "12sp",
      layout_width = "match_parent",
      layout_height = "wrap_content",
      padding = "4dp",
      gravity = "center",
      maxLines = 2,
      ellipsize = "end",
      background = createRoundRectDrawable(theme.SURFACE_VARIANT, 8),
      layout_marginBottom = "8dp"
    },
    {
      ListView,
      id = "xfq_lvSongs",
      layout_width = "match_parent",
      layout_height = "120dp",
      dividerHeight = "0dp",
      padding = "4dp"
    },
    {
      LinearLayout,
      orientation = "horizontal",
      layout_width = "match_parent",
      layout_height = "wrap_content",
      gravity = "center_vertical",
      paddingTop = "4dp",
      paddingBottom = "4dp",
      {
        ProgressBar,
        id = "xfq_pbSong",
        style = "?android:attr/progressBarStyleHorizontal",
        layout_width = "0dp",
        layout_height = "10dp",
        layout_weight = "1",
        max = 1000,
        progress = 0,
        indeterminate = false,
        progressDrawable = createProgressDrawable()
      }
    },
    {
      LinearLayout,
      orientation = "horizontal",
      layout_width = "match_parent",
      layout_height = "wrap_content",
      {
        TextView,
        id = "xfq_tvCurrentTime",
        text = "00:00",
        textColor = theme.TEXT_COLOR,
        textSize = "10sp",
        layout_width = "wrap_content",
        layout_height = "wrap_content",
        layout_weight = "1"
      },
      {
        TextView,
        id = "xfq_tvTotalTime",
        text = "00:00",
        textColor = theme.TEXT_COLOR,
        textSize = "10sp",
        layout_width = "wrap_content",
        layout_height = "wrap_content",
        gravity = "right"
      },
      {
        ImageButton,
        id = "xfq_btnLoop",
        layout_width = "20dp",
        layout_height = "20dp",
        background = nil,
        backgroundColor = Color.TRANSPARENT,
        scaleType = "fitCenter",
        padding = "2dp"
      }
    },
    {
      Space,
      layout_width = "match_parent",
      layout_height = "8dp"
    },
    {
      LinearLayout,
      orientation = "horizontal",
      layout_width = "match_parent",
      layout_height = "wrap_content",
      gravity = "center",
      {
        MaterialButton,
        id = "xfq_btnPlay",
        text = "播放",
        layout_width = "0dp",
        layout_height= "36dp",
        layout_weight= "1",
        layout_marginRight = "4dp",
        textColor = theme.TEXT_COLOR,
        backgroundColor = theme.SURFACE_VARIANT,
        rippleColor = theme.BORDER,
        cornerRadius = "8dp",
        textSize = "12sp",
        allCaps = false,
        stateListAnimator = nil,
        elevation = "0dp"
      },
      {
        MaterialButton,
        id = "xfq_btnClose",
        text = "关闭",
        layout_width = "0dp",
        layout_height= "36dp",
        layout_weight= "1",
        textColor = Color.WHITE,
        backgroundColor = theme.PRIMARY,
        rippleColor = theme.PRIMARY_DARK,
        cornerRadius = "8dp",
        textSize = "12sp",
        allCaps = false,
        stateListAnimator = nil,
        elevation = "0dp"
      }
    }
  }
end

local function createFloatingBallLayout()
  return {
    LinearLayout,
    id = "xfq_ball",
    layout_width = "56dp",
    layout_height= "56dp",
    background = createRoundRectDrawable(Color.parseColor("#99FFFFFF"), 6),
    gravity = "center",
    {
      ImageView,
      layout_width = "24dp",
      layout_height= "24dp",
      src = "ic_music_note_white_24dp",
      colorFilter = Color.parseColor("#FFFFFF")
    }
  }
end

floatingWindow = loadlayout(createFloatingWindowLayout())
floatingBall = loadlayout(createFloatingBallLayout())

local function updateFloatingWindowList()
  xfqsongs = loadSavedSongs()
  adapter_xfq.clear()
  for _, entry in ipairs(xfqsongs) do
    adapter_xfq.add(entry.name .. " - " .. entry.artist)
  end
  adapter_xfq.notifyDataSetChanged()
end

updateFloatingWindowList()
xfq_lvSongs.adapter = adapter_xfq
xfq_lvSongs.setDividerHeight(0)
xfq_lvSongs.setCacheColorHint(0x00000000)
local defaultXfqBg = createRoundRectDrawable(themeColors[currentThemeIndex].CARD_BG, 12)
local pressedXfqBg = createRoundRectDrawable(Color.parseColor("#BBDEFB"), 12)
local xfqSelector = StateListDrawable()
xfqSelector.addState({android.R.attr.state_pressed}, pressedXfqBg)
xfqSelector.addState({}, defaultXfqBg)
xfq_lvSongs.setSelector(xfqSelector)
wmParams.width = WindowManager.LayoutParams.WRAP_CONTENT
wmParams.height = WindowManager.LayoutParams.WRAP_CONTENT
wmParams.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
wmParams.format = PixelFormat.TRANSLUCENT
wmParams.type = WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
wmParams.gravity = Gravity.LEFT | Gravity.TOP
wmParamsBall.width = WindowManager.LayoutParams.WRAP_CONTENT
wmParamsBall.height = WindowManager.LayoutParams.WRAP_CONTENT
wmParamsBall.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
wmParamsBall.format = PixelFormat.TRANSLUCENT
wmParamsBall.type = WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
wmParamsBall.gravity = Gravity.LEFT | Gravity.TOP
wmParamsBall.x = math.floor((screenWidth - ballSizePx) / 2)
wmParamsBall.y = math.floor((screenHeight - ballSizePx) / 2)
local threshold = dp2px(2)
local scaleDown = 0.9
local animDuration = 100

local function setupDrag(view, params, isBall)
  local firstX, firstY, initX, initY
  view.setOnTouchListener(function(v, event)
    local action = event.getAction()
    if action == MotionEvent.ACTION_DOWN then
      firstX = event.getRawX()
      firstY = event.getRawY()
      initX = params.x
      initY = params.y
      view.animate().scaleX(scaleDown).scaleY(scaleDown).setDuration(animDuration).start()
      return true
     elseif action == MotionEvent.ACTION_MOVE then
      local dx = event.getRawX() - firstX
      local dy = event.getRawY() - firstY
      if math.abs(dx) > threshold or math.abs(dy) > threshold then
        params.x = initX + dx
        params.y = initY + dy
        wm.updateViewLayout(view, params)
      end
      return true
     elseif action == MotionEvent.ACTION_UP or action == MotionEvent.ACTION_CANCEL then
      view.animate().scaleX(1.0).scaleY(1.0).setDuration(animDuration).start()
      local dx = event.getRawX() - firstX
      local dy = event.getRawY() - firstY
      if isBall and math.abs(dx) < threshold and math.abs(dy) < threshold then
        showFloatingWindow()
      end
      return true
    end
    return false
  end)
end

setupDrag(floatingWindow, wmParams, false)
setupDrag(floatingBall, wmParamsBall, true)

local function ensureOverlayPermission()
  if not Settings.canDrawOverlays(activity) then
    local intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
    Uri.parse("package:"..activity.getPackageName()))
    activity.startActivityForResult(intent, 0)
    return false
  end
  return true
end

function showFloatingWindow()
  if not ensureOverlayPermission() then return end
  updateFloatingWindowList()
  if isFloatingWindowOpen or isAnimating then return end

  if isFloatingBallVisible then
    wmParams.x = wmParamsBall.x - (dp2px(280) - ballSizePx) / 2
    wmParams.y = wmParamsBall.y - (dp2px(240) - ballSizePx) / 2 + dp2px(24)
    wm.removeView(floatingBall)
    isFloatingBallVisible = false
   else
    wmParams.x = math.floor((screenWidth - dp2px(280)) / 2)
    wmParams.y = math.floor((screenHeight - dp2px(240)) / 2) + dp2px(24)
  end

  if currentSong then
    xfq_nowPlaying.text = "正在播放: " .. currentSong.name .. " - " .. currentSong.artist
   else
    xfq_nowPlaying.text = "当前未播放"
  end

  if xfq_btnPlay then
    xfq_btnPlay.text = isPlaying and "暂停" or "播放"
  end

  if xfq_btnLoop then
    if isLooping then
      xfq_btnLoop.setImageBitmap(loadbitmap("kyxh.png"))
    else
      xfq_btnLoop.setImageBitmap(loadbitmap("gbzt.png"))
    end
  end

  xfq_btnPlay.onClick = function()
    togglePlayPause()
    if xfq_btnPlay then
      xfq_btnPlay.text = isPlaying and "暂停" or "播放"
    end
  end

  xfq_btnLoop.onClick = function()
    toggleLooping()
  end

  xfq_pbSong.setOnTouchListener({
    onTouch = function(v, event)
      if currentSong and mediaPlayer then
        local action = event.getAction()
        if action == MotionEvent.ACTION_DOWN then
          updateProgressHandler.removeCallbacks(updateProgressRunnable)
          return true
         elseif action == MotionEvent.ACTION_MOVE then
          local x = event.getX()
          local width = v.getWidth()
          local ratio = x / width
          if ratio < 0 then ratio = 0 end
          if ratio > 1 then ratio = 1 end
          local prog = math.floor(ratio * 1000)
          xfq_pbSong.setProgress(prog)
          if pbSong then
            pbSong.setProgress(prog)
          end
          if mediaPlayer.getDuration() > 0 then
            xfq_tvCurrentTime.text = formatTime(math.floor(ratio * mediaPlayer.getDuration()))
            if tvCurrentTime then
              tvCurrentTime.text = formatTime(math.floor(ratio * mediaPlayer.getDuration()))
            end
          end
          return true
         elseif action == MotionEvent.ACTION_UP then
          local x = event.getX()
          local width = v.getWidth()
          local ratio = x / width
          if ratio < 0 then ratio = 0 end
          if ratio > 1 then ratio = 1 end
          if not mediaPlayer.isPlaying() and not isPlaying then
            isPlaying = true
            if btnPlay then
              btnPlay.text = "暂停"
            end
            if xfq_btnPlay then
              xfq_btnPlay.text = "暂停"
            end
          end
          if mediaPlayer.getDuration() > 0 then
            local seekPos = math.floor(ratio * mediaPlayer.getDuration())
            mediaPlayer.seekTo(seekPos)
            if not mediaPlayer.isPlaying() then
              mediaPlayer.start()
            end
            xfq_pbSong.setProgress(math.floor(ratio * 1000))
            if pbSong then
              pbSong.setProgress(math.floor(ratio * 1000))
            end
            xfq_tvCurrentTime.text = formatTime(seekPos)
            if tvCurrentTime then
              tvCurrentTime.text = formatTime(seekPos)
            end
            if xfq_nowPlaying then
              xfq_nowPlaying.text = "正在播放: " .. currentSong.name
            end
          end
          if isPlaying then
            updateProgressHandler.post(updateProgressRunnable)
          end
          return true
        end
      end
      return false
    end
  })

  floatingWindow.setScaleX(0.8)
  floatingWindow.setScaleY(0.8)
  floatingWindow.setAlpha(0.0)

  wm.addView(floatingWindow, wmParams)
  isFloatingWindowOpen = true

  floatingWindow.animate()
  .scaleX(1.0)
  .scaleY(1.0)
  .alpha(1.0)
  .setDuration(300)
  .withEndAction(Runnable({
    run = function()
      isAnimating = false
    end
  }))
  .start()
  isAnimating = true

  xfq_lvSongs.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick = function(parent, view, position, id)
      local index = position + 1
      if index <= #xfqsongs then
        local entry = xfqsongs[index]
        playMusic(entry)
        xfq_nowPlaying.text = "正在播放: " .. entry.name .. " - " .. entry.artist
        if xfq_btnPlay then
          xfq_btnPlay.text = "暂停"
        end
      end
    end
  })

  xfq_lvSongs.setOnItemLongClickListener(AdapterView.OnItemLongClickListener{
    onItemLongClick = function(parent, view, position, id)
      local index = position + 1
      if index <= #xfqsongs then
        local entry = xfqsongs[index]
        deleteSongFromDB(entry.id)
        table.remove(xfqsongs, index)
        adapter_xfq.remove(adapter_xfq.getItem(position))
        adapter_xfq.notifyDataSetChanged()
        Toast.makeText(activity, "✔ 已删除: " .. entry.name .. " - " .. entry.artist, Toast.LENGTH_SHORT).show()
        if currentSong and currentSong.id == entry.id then
          if mediaPlayer then
            mediaPlayer.stop()
            mediaPlayer.release()
            mediaPlayer = nil
          end
          currentSong = nil
          isPlaying = false
          if btnPlay then
            btnPlay.text = "播放"
          end
          if xfq_btnPlay then
            xfq_btnPlay.text = "播放"
          end
          tvStatus.text = "已删除当前播放歌曲"
          xfq_nowPlaying.text = "当前未播放"
        end
      end
      return true
    end
  })

  xfq_btnClose.onClick = function()
    if not isFloatingWindowOpen or isAnimating then return end
    isAnimating = true

    floatingWindow.animate()
    .scaleX(0.8)
    .scaleY(0.8)
    .alpha(0.0)
    .setDuration(300)
    .withEndAction(Runnable({
      run = function()
        Handler().postDelayed(Runnable({
          run = function()
            pcall(function()
              wm.removeView(floatingWindow)
            end)
            isFloatingWindowOpen = false
            isAnimating = false

            floatingBall.setAlpha(0.0)
            wm.addView(floatingBall, wmParamsBall)
            isFloatingBallVisible = true
            floatingBall.animate()
            .alpha(1.0)
            .setDuration(300)
            .start()
          end
        }), 50)
      end
    }))
    .start()
  end
end

local function updateFloatingWindowTheme()
  if not isFloatingWindowOpen or isAnimating then return end
  local currentX = wmParams.x
  local currentY = wmParams.y

  wm.removeView(floatingWindow)
  isFloatingWindowOpen = false

  floatingWindow = loadlayout(createFloatingWindowLayout())
  setupDrag(floatingWindow, wmParams, false)
  updateFloatingWindowList()
  xfq_lvSongs.adapter = adapter_xfq

  if currentSong then
    xfq_nowPlaying.text = "正在播放: " .. currentSong.name .. " - " .. currentSong.artist
   else
    xfq_nowPlaying.text = "当前未播放"
  end

  if xfq_btnPlay then
    xfq_btnPlay.text = isPlaying and "暂停" or "播放"
  end

  if xfq_btnLoop then
    if isLooping then
      xfq_btnLoop.setImageBitmap(loadbitmap("kyxh.png"))
    else
      xfq_btnLoop.setImageBitmap(loadbitmap("gbzt.png"))
    end
  end

  xfq_btnPlay.onClick = function()
    togglePlayPause()
    if xfq_btnPlay then
      xfq_btnPlay.text = isPlaying and "暂停" or "播放"
    end
  end

  xfq_btnLoop.onClick = function()
    toggleLooping()
  end

  xfq_pbSong.setOnTouchListener({
    onTouch = function(v, event)
      if currentSong and mediaPlayer then
        local action = event.getAction()
        if action == MotionEvent.ACTION_DOWN then
          updateProgressHandler.removeCallbacks(updateProgressRunnable)
          return true
         elseif action == MotionEvent.ACTION_MOVE then
          local x = event.getX()
          local width = v.getWidth()
          local ratio = x / width
          if ratio < 0 then ratio = 0 end
          if ratio > 1 then ratio = 1 end
          local prog = math.floor(ratio * 1000)
          xfq_pbSong.setProgress(prog)
          if pbSong then
            pbSong.setProgress(prog)
          end
          if mediaPlayer.getDuration() > 0 then
            xfq_tvCurrentTime.text = formatTime(math.floor(ratio * mediaPlayer.getDuration()))
            if tvCurrentTime then
              tvCurrentTime.text = formatTime(math.floor(ratio * mediaPlayer.getDuration()))
            end
          end
          return true
         elseif action == MotionEvent.ACTION_UP then
          local x = event.getX()
          local width = v.getWidth()
          local ratio = x / width
          if ratio < 0 then ratio = 0 end
          if ratio > 1 then ratio = 1 end
          if not mediaPlayer.isPlaying() and not isPlaying then
            isPlaying = true
            if btnPlay then
              btnPlay.text = "暂停"
            end
            if xfq_btnPlay then
              xfq_btnPlay.text = "暂停"
            end
          end
          if mediaPlayer.getDuration() > 0 then
            local seekPos = math.floor(ratio * mediaPlayer.getDuration())
            mediaPlayer.seekTo(seekPos)
            if not mediaPlayer.isPlaying() then
              mediaPlayer.start()
            end
            xfq_pbSong.setProgress(math.floor(ratio * 1000))
            if pbSong then
              pbSong.setProgress(math.floor(ratio * 1000))
            end
            xfq_tvCurrentTime.text = formatTime(seekPos)
            if tvCurrentTime then
              tvCurrentTime.text = formatTime(seekPos)
            end
            if xfq_nowPlaying then
              xfq_nowPlaying.text = "正在播放: " .. currentSong.name
            end
          end
          if isPlaying then
            updateProgressHandler.post(updateProgressRunnable)
          end
          return true
        end
      end
      return false
    end
  })

  floatingWindow.setScaleX(0.8)
  floatingWindow.setScaleY(0.8)
  floatingWindow.setAlpha(0.0)
  wmParams.x = currentX
  wmParams.y = currentY
  wm.addView(floatingWindow, wmParams)
  isFloatingWindowOpen = true
  isAnimating = true
  floatingWindow.animate()
  .scaleX(1.0)
  .scaleY(1.0)
  .alpha(1.0)
  .setDuration(300)
  .withEndAction(Runnable({
    run = function()
      isAnimating = false
    end
  }))
  .start()
end

local function showThemeProgressDialog(themeName)
    if themeName == nil then
        themeName = ""
    end

    local progressLayout = {
        LinearLayout,
        id = "dialogRoot",
        orientation = "vertical",
        layout_width = "280dp",
        layout_height = "wrap_content",
        padding = "16dp",
        background = createBorderDrawable(COLOR_SURFACE, COLOR_BORDER, 1, 16),
        {
            TextView,
            id = "tvLoading",
            text = "正在应用: "..themeName,
            textColor = COLOR_TEXT,
            textSize = "14sp",
            layout_width = "match_parent",
            layout_height = "wrap_content",
            gravity = "left",
            paddingLeft = "4dp",
            paddingBottom = "12dp"
        },
        {
            ProgressBar,
            id = "progressBar",
            style = "?android:attr/progressBarStyleHorizontal",
            layout_width = "match_parent",
            layout_height = "8dp",
            progress = 0,
            progressDrawable = createProgressDrawable()
        }
    }

    local dialog = AlertDialog.Builder(activity)
    .setView(loadlayout(progressLayout))
    .setCancelable(false)
    .show()

    local window = dialog.getWindow()
    window.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
    window.setDimAmount(0.3)

    local progressAnimator = ObjectAnimator.ofInt(progressBar, "progress", {0, 100})
    progressAnimator.setDuration(1200)
    progressAnimator.setInterpolator(AccelerateInterpolator())

    local bounceAnimator = ObjectAnimator.ofFloat(progressBar, "translationY", {0, -dp2px(4), 0})
    bounceAnimator.setDuration(300)
    bounceAnimator.setInterpolator(BounceInterpolator())

    progressAnimator.addListener({
        onAnimationEnd = function()
            bounceAnimator.start()
        end
    })

    progressAnimator.start()

    return dialog
end

local function switchTheme(themeIndex)
    if themeIndex == nil or themeColors[themeIndex] == nil then
        Toast.makeText(activity, "无效的主题", Toast.LENGTH_SHORT).show()
        return
    end

    local theme = themeColors[themeIndex]
    local progressDialog = showThemeProgressDialog(theme.name)
    
    Handler().postDelayed(Runnable{
        run = function()
            progressDialog.dismiss()
            currentThemeIndex = themeIndex
            updateThemeColors()
            activity.recreate()
        end
    }, 1500)
end

local function createThemePreview(theme, isSelected)
  local preview = LinearLayout(activity)
  preview.setOrientation(LinearLayout.VERTICAL)
  preview.setBackground(createBorderDrawable(
  isSelected and Color.parseColor("#E3F2FD") or theme.CARD_BG,
  isSelected and theme.PRIMARY or theme.BORDER,
  isSelected and 2 or 1,
  16
  ))
  preview.setPadding(dp2px(16), dp2px(16), dp2px(16), dp2px(16))

  local name = TextView(activity)
  name.setText(theme.name)
  name.setTextColor(theme.TEXT_COLOR)
  name.setTextSize(16)
  name.setTypeface(Typeface.DEFAULT_BOLD)
  preview.addView(name)

  local desc = TextView(activity)
  desc.setText(theme.description)
  desc.setTextColor(theme.TEXT_COLOR)
  desc.setTextSize(12)
  desc.setPadding(0, dp2px(4), 0, dp2px(8))
  preview.addView(desc)

  local colorBar = LinearLayout(activity)
  colorBar.setOrientation(LinearLayout.HORIZONTAL)
  colorBar.setLayoutParams(LinearLayout.LayoutParams(
  LinearLayout.LayoutParams.MATCH_PARENT,
  dp2px(36)
  ))
  colorBar.setGravity(Gravity.CENTER_VERTICAL)
  colorBar.setPadding(0, dp2px(8), 0, 0)
  local colors = {
    theme.PRIMARY,
    theme.PRIMARY_DARK,
    theme.SURFACE_VARIANT
  }
  for i, color in ipairs(colors) do
    local colorView = View(activity)
    colorView.setBackground(createRoundRectDrawable(color, 8))
    local params = LinearLayout.LayoutParams(
    0,
    dp2px(24),
    1
    )
    if i ~= #colors then
      params.setMargins(0, 0, dp2px(8), 0)
    end
    colorView.setLayoutParams(params)
    colorBar.addView(colorView)
  end
  preview.addView(colorBar)

  if isSelected then
    local checkMark = TextView(activity)
    checkMark.setText("✓ 已选择")
    checkMark.setTextColor(theme.PRIMARY)
    checkMark.setTextSize(14)
    checkMark.setGravity(Gravity.RIGHT)
    checkMark.setPadding(0, dp2px(8), 0, 0)
    preview.addView(checkMark)
  end
  return preview
end

local function saveThemeSettings()
    local editor = prefs.edit()
    editor.putInt("theme_index", currentThemeIndex)
    editor.putBoolean("apply_to_float", applyThemeToFloatWindow)
    editor.putBoolean("float_window_transparent", isFloatWindowTransparent)
    editor.putBoolean("use_vulkan_render", useVulkanRender)
    editor.putBoolean("low_performance_mode", isLowPerformanceMode)
    editor.putBoolean("dynamic_island_enabled", isDynamicIslandEnabled)
    editor.putBoolean("surround_enabled", surroundSoundEnabled)
    editor.putString("surround_speed", tostring(surroundSoundSpeed))
    editor.apply()
end

local function showEmailFeedbackDialog()
    local function createRoundRectBg(cornersRadius, bgColor)
        local radii = {cornersRadius, cornersRadius, cornersRadius, cornersRadius,
                      cornersRadius, cornersRadius, cornersRadius, cornersRadius}
        local roundRectShape = RoundRectShape(radii, nil, nil)
        local shapeDrawable = ShapeDrawable(roundRectShape)
        shapeDrawable.getPaint().setColor(bgColor)
        return shapeDrawable
    end

    local function createButtonBg(normalColor, pressedColor)
        local states = StateListDrawable()
        
        local normal = GradientDrawable()
        normal.setShape(GradientDrawable.RECTANGLE)
        normal.setCornerRadius(dp2px(8))
        normal.setColor(normalColor)
        
        local pressed = GradientDrawable()
        pressed.setShape(GradientDrawable.RECTANGLE)
        pressed.setCornerRadius(dp2px(8))
        pressed.setColor(pressedColor)
        
        states.addState({android.R.attr.state_pressed}, pressed)
        states.addState({}, normal)
        return states
    end

    -- 创建模糊背景函数（根据API版本选择不同实现）
    local function createBlurBackground()
        if Build.VERSION.SDK_INT >= 31 then
            -- API 31+ 使用RenderEffect实现实时模糊
            local decorView = activity.getWindow().getDecorView()
            return {
                view = decorView,
                applyBlur = function(radius)
                    local blurEffect = RenderEffect.createBlurEffect(
                        radius, radius, Shader.TileMode.CLAMP)
                    decorView.setRenderEffect(blurEffect)
                end,
                clearBlur = function()
                    decorView.setRenderEffect(nil)
                end
            }
        else
            -- 低版本使用Bitmap模糊（性能较差）
            local rootView = activity.getWindow().getDecorView().getRootView()
            rootView.setDrawingCacheEnabled(true)
            rootView.buildDrawingCache()
            
            local bmp = rootView.getDrawingCache()
            local blurBmp = Bitmap.createBitmap(bmp.getWidth(), bmp.getHeight(), Bitmap.Config.ARGB_8888)
            local canvas = Canvas(blurBmp)
            
            local paint = Paint()
            paint.setMaskFilter(BlurMaskFilter(25, BlurMaskFilter.Blur.NORMAL))
            
            canvas.drawBitmap(bmp, 0, 0, paint)
            rootView.setDrawingCacheEnabled(false)
            
            return {
                drawable = BitmapDrawable(activity.getResources(), blurBmp),
                clearBlur = function() end
            }
        end
    end

    local layout = LinearLayout(activity)
    layout.setOrientation(LinearLayout.VERTICAL)
    layout.setPadding(dp2px(16), dp2px(16), dp2px(16), dp2px(16))
    layout.setBackground(createRoundRectBg(dp2px(20), Color.parseColor("#E6FFFFFF")))
    layout.setVisibility(View.INVISIBLE)

    local contentContainer = LinearLayout(activity)
    contentContainer.setOrientation(LinearLayout.VERTICAL)
    contentContainer.setVisibility(View.INVISIBLE)

    local nameInput = EditText(activity)
    nameInput.setHint("该怎么称呼你呢？")
    nameInput.setTextSize(16)
    nameInput.setPadding(dp2px(10), dp2px(10), dp2px(10), dp2px(10))
    nameInput.setBackground(createRoundRectBg(dp2px(15), Color.WHITE))
    nameInput.setLayoutParams(LinearLayout.LayoutParams(
        LinearLayout.LayoutParams.MATCH_PARENT,
        LinearLayout.LayoutParams.WRAP_CONTENT
    ))
    contentContainer.addView(nameInput)

    local space = LinearLayout.LayoutParams(
        LinearLayout.LayoutParams.MATCH_PARENT,
        dp2px(8)
    )
    contentContainer.addView(LinearLayout(activity), space)

    local inputBox = EditText(activity)
    inputBox.setHint("请详细描述你的问题或建议...\n填写后将以邮件形式发送")
    inputBox.setGravity(Gravity.TOP|Gravity.LEFT)
    inputBox.setTextSize(16)
    inputBox.setPadding(dp2px(10), dp2px(10), dp2px(10), dp2px(10))
    inputBox.setBackground(createRoundRectBg(dp2px(15), Color.WHITE))
    inputBox.setLayoutParams(LinearLayout.LayoutParams(
        LinearLayout.LayoutParams.MATCH_PARENT,
        dp2px(120)
    ))
    contentContainer.addView(inputBox)

    local buttonContainer = LinearLayout(activity)
    buttonContainer.setOrientation(LinearLayout.HORIZONTAL)
    buttonContainer.setGravity(Gravity.CENTER)
    buttonContainer.setLayoutParams(LinearLayout.LayoutParams(
        LinearLayout.LayoutParams.MATCH_PARENT,
        LinearLayout.LayoutParams.WRAP_CONTENT
    ))

    local sendBtnParams = LinearLayout.LayoutParams(
        dp2px(120),
        dp2px(45)
    )
    sendBtnParams.setMargins(dp2px(8), dp2px(16), dp2px(8), dp2px(8))
    
    local sendBtn = Button(activity)
    sendBtn.setText("发送反馈")
    sendBtn.setTextColor(Color.WHITE)
    sendBtn.setBackground(createButtonBg(
        Color.parseColor("#2196F3"), 
        Color.parseColor("#1976D2")
    ))
    sendBtn.setLayoutParams(sendBtnParams)

    local cancelBtnParams = LinearLayout.LayoutParams(
        dp2px(120),
        dp2px(45)
    )
    cancelBtnParams.setMargins(dp2px(8), dp2px(16), dp2px(8), dp2px(8))
    
    local cancelBtn = Button(activity)
    cancelBtn.setText("取消")
    cancelBtn.setTextColor(Color.WHITE)
    cancelBtn.setBackground(createButtonBg(
        Color.parseColor("#FFFF0000"),
        Color.parseColor("#FFFF0000")
    ))
    cancelBtn.setLayoutParams(cancelBtnParams)

    buttonContainer.addView(sendBtn)
    buttonContainer.addView(cancelBtn)
    contentContainer.addView(buttonContainer)

    layout.addView(contentContainer)

    local dialog = AlertDialog.Builder(activity)
    .setTitle("意见反馈")
    .setView(layout)
    .create()

    dialog.setCancelable(false)
    dialog.setCanceledOnTouchOutside(false)

    dialog.getWindow().setBackgroundDrawableResource(android.R.color.transparent)
    dialog.getWindow().setLayout(
        WindowManager.LayoutParams.MATCH_PARENT,
        WindowManager.LayoutParams.WRAP_CONTENT
    )
    
    local blurBackground = createBlurBackground()
    local rootLayout = LinearLayout(activity)
    rootLayout.setLayoutParams(ViewGroup.LayoutParams(
        ViewGroup.LayoutParams.MATCH_PARENT,
        ViewGroup.LayoutParams.MATCH_PARENT
    ))
    
    if Build.VERSION.SDK_INT >= 31 then
        rootLayout.addView(layout)
    else
        rootLayout.setBackgroundDrawable(blurBackground.drawable)
        rootLayout.addView(layout)
    end
    
    dialog.setView(rootLayout)

    dialog.setOnShowListener({
        onShow = function()
            if Build.VERSION.SDK_INT >= 31 then
                blurBackground.applyBlur(25)
            end
            
            rootLayout.setVisibility(View.VISIBLE)
            
            layout.setVisibility(View.VISIBLE)
            local bgAnim = AlphaAnimation(0, 1)
            bgAnim.setDuration(400)
            bgAnim.setFillAfter(true)
            layout.startAnimation(bgAnim)
            
            layout.postDelayed(function()
                contentContainer.setVisibility(View.VISIBLE)
                
                local animSet = AnimationSet(true)
                
                local translateAnim = TranslateAnimation(
                    Animation.RELATIVE_TO_SELF, 0,
                    Animation.RELATIVE_TO_SELF, 0,
                    Animation.RELATIVE_TO_SELF, 0.2,
                    Animation.RELATIVE_TO_SELF, 0
                )
                translateAnim.setDuration(600)
                
                local alphaAnim = AlphaAnimation(0, 1)
                alphaAnim.setDuration(600)
                
                animSet.addAnimation(translateAnim)
                animSet.addAnimation(alphaAnim)
                animSet.setInterpolator(DecelerateInterpolator())
                animSet.setFillAfter(true)
                
                contentContainer.startAnimation(animSet)
            end, 200)
        end
    })

    sendBtn.onClick = function()
        local name = nameInput.getText().toString()
        local content = inputBox.getText().toString()
        
        if name == "" then
            Toast.makeText(activity, "请先告诉我怎么称呼你", Toast.LENGTH_SHORT).show()
            return
        end
        
        if content == "" then
            Toast.makeText(activity, "请填写反馈内容后再发送", Toast.LENGTH_SHORT).show()
            return
        end

        local targetEmail = "2165009591@qq.com"
        local intent = Intent(Intent.ACTION_SENDTO)
        intent.setData(Uri.parse("mailto:"..targetEmail))
        intent.putExtra(Intent.EXTRA_SUBJECT, "来自blue Aurora的反馈 - "..name)
        intent.putExtra(Intent.EXTRA_TEXT, "用户称呼: "..name.."\n\n反馈内容:\n"..content)

        if intent.resolveActivity(activity.getPackageManager()) ~= nil then
            activity.startActivity(intent)
        else
            Toast.makeText(activity, "未找到邮件应用，请先安装邮件客户端", Toast.LENGTH_SHORT).show()
        end
    end

    cancelBtn.onClick = function()
        local animSet = AnimationSet(true)
        
        local translateAnim = TranslateAnimation(
            Animation.RELATIVE_TO_SELF, 0,
            Animation.RELATIVE_TO_SELF, 0,
            Animation.RELATIVE_TO_SELF, 0,
            Animation.RELATIVE_TO_SELF, 0.2
        )
        translateAnim.setDuration(500)
        
        local alphaAnim = AlphaAnimation(1, 0)
        alphaAnim.setDuration(500)
        
        animSet.addAnimation(translateAnim)
        animSet.addAnimation(alphaAnim)
        animSet.setInterpolator(DecelerateInterpolator())
        animSet.setFillAfter(true)
        
        contentContainer.startAnimation(animSet)
        
        local bgAnim = AlphaAnimation(1, 0)
        bgAnim.setDuration(500)
        bgAnim.setFillAfter(true)
        layout.startAnimation(bgAnim)
        
        local blurAnim = AlphaAnimation(1, 0)
        blurAnim.setDuration(500)
        blurAnim.setFillAfter(true)
        rootLayout.startAnimation(blurAnim)
        
        animSet.setAnimationListener({
            onAnimationEnd = function()
                blurBackground.clearBlur()
                dialog.dismiss()
            end
        })
    end

    dialog.show()
end
local function showThemeSelection()
    local safeBackgroundColor = COLOR_BACKGROUND or 0xFF000000
    local safeBorderColor = COLOR_BORDER or 0xFF888888
    
    local currentListTypeBeforeSettings = currentListType
    local searchResultsBeforeSettings = searchResults
    local favoritesBeforeSettings = favorites
    local adapterBeforeSettings = adapter
    
    local settingsView, scrollView, circleView, rootLayout
    
    local function performBackAction()
        saveThemeSettings()
        loadAndCacheBackground()
        
        settingsView.animate()
            .scaleX(0)
            .scaleY(0)
            .alpha(0)
            .setDuration(300)
            .setInterpolator(DecelerateInterpolator())
            .setListener({
                onAnimationEnd = function()
                    local newMainView = loadlayout(createMainUI())
                    newMainView.setAlpha(0)
                    newMainView.setScaleX(0.9)
                    newMainView.setScaleY(0.9)
                    activity.setContentView(newMainView)
                    
                    currentListType = currentListTypeBeforeSettings
                    searchResults = searchResultsBeforeSettings
                    favorites = favoritesBeforeSettings
                    
                    if currentListType == "search" and #searchResults > 0 then
                        adapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1)
                        for i, song in ipairs(searchResults) do
                            adapter.add(song.name .. "\n" .. song.artist)
                        end
                        lvSongs.setAdapter(adapter)
                        tvListTitle.text = "搜索结果 (" .. #searchResults .. " 首)"
                    elseif currentListType == "favorites" and #favorites > 0 then
                        adapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1)
                        for i, fav in ipairs(favorites) do
                            adapter.add(fav.name .. "\n" .. fav.artist)
                        end
                        lvSongs.setAdapter(adapter)
                        tvListTitle.text = "收藏列表 (" .. #favorites .. " 首)"
                    end
                    
                    newMainView.animate()
                        .scaleX(1)
                        .scaleY(1)
                        .alpha(1)
                        .setDuration(300)
                        .setInterpolator(OvershootInterpolator(1.2))
                        .withEndAction(Runnable{
                            run = function()
                                setupEventListeners()
                                applyBackground()
                            end
                        })
                        .start()
                end
            })
            .start()
    end

    -- 主设置视图
    settingsView = LinearLayout(activity)
    settingsView.setOrientation(LinearLayout.VERTICAL)
    settingsView.setBackgroundColor(COLOR_SURFACE)
    settingsView.setPadding(dp2px(16), dp2px(16), dp2px(16), dp2px(16))
    settingsView.setAlpha(0)
    settingsView.setVisibility(View.INVISIBLE)

    local titleBar = LinearLayout(activity)
    titleBar.setOrientation(LinearLayout.HORIZONTAL)
    titleBar.setGravity(Gravity.CENTER_VERTICAL)
    titleBar.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(56)))
    titleBar.setPadding(dp2px(4), 0, dp2px(4), dp2px(8))

    local title = TextView(activity)
    title.setText("设置与个性化")
    title.setTextColor(COLOR_TEXT)
    title.setTextSize(20)
    title.setTypeface(Typeface.DEFAULT_BOLD)
    title.setLayoutParams(LinearLayout.LayoutParams(-2, -2, 1))
    title.setPadding(dp2px(0), 0, dp2px(16), 0)

    local backButton = ImageView(activity)
    backButton.setImageBitmap(loadbitmap("res/SEEFH.png"))
    backButton.setColorFilter(0xFF888888)
    backButton.setScaleType(ImageView.ScaleType.FIT_CENTER)
    
    local btnParams = LinearLayout.LayoutParams(dp2px(56), dp2px(56))
    btnParams.gravity = Gravity.CENTER_VERTICAL
    backButton.setLayoutParams(btnParams)
    backButton.setPadding(dp2px(16), dp2px(16), dp2px(16), dp2px(16))
    
    backButton.setOnTouchListener{
        onTouch = function(v, event)
            if event.action == MotionEvent.ACTION_DOWN then
                v.animate().scaleX(0.9).scaleY(0.9).setDuration(100).start()
                return true
            elseif event.action == MotionEvent.ACTION_UP then
                v.animate().scaleX(1).scaleY(1).setDuration(100).start()
                performBackAction()
                return true
            elseif event.action == MotionEvent.ACTION_CANCEL then
                v.animate().scaleX(1).scaleY(1).setDuration(100).start()
                return true
            end
            return false
        end
    }
    
    titleBar.addView(title)
    titleBar.addView(backButton)
    settingsView.addView(titleBar)

    local syncCard = MaterialCardView(activity)
    syncCard.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(48)))
    syncCard.setCardBackgroundColor(COLOR_CARD_BG)
    syncCard.setStrokeColor(safeBorderColor)
    syncCard.setStrokeWidth(dp2px(1))
    syncCard.setRadius(dp2px(16))
    syncCard.setElevation(0)
    syncCard.setContentPadding(dp2px(16), dp2px(8), dp2px(16), dp2px(8))

    local syncLayout = LinearLayout(activity)
    syncLayout.setOrientation(LinearLayout.HORIZONTAL)
    syncLayout.setGravity(Gravity.CENTER_VERTICAL)
    
    local syncText = TextView(activity)
    syncText.setText("将主题颜色同步到悬浮窗")
    syncText.setTextColor(COLOR_TEXT)
    syncText.setTextSize(16)
    syncText.setLayoutParams(LinearLayout.LayoutParams(-2, -2, 1))
    
    local syncSwitch = MaterialSwitch(activity)
    syncSwitch.setChecked(applyThemeToFloatWindow)
    syncSwitch.setLayoutParams(LinearLayout.LayoutParams(-2, -2))
    
    syncSwitch.setOnCheckedChangeListener{
        onCheckedChanged = function(_, isChecked)
            applyThemeToFloatWindow = isChecked
        end
    }
    
    syncLayout.addView(syncText)
    syncLayout.addView(syncSwitch)
    syncCard.addView(syncLayout)
    settingsView.addView(syncCard)

    local space1 = View(activity)
    space1.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(8)))
    settingsView.addView(space1)

    -- 透明背景设置项
    local transparentCard = MaterialCardView(activity)
    transparentCard.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(48)))
    transparentCard.setCardBackgroundColor(COLOR_CARD_BG)
    transparentCard.setStrokeColor(safeBorderColor)
    transparentCard.setStrokeWidth(dp2px(1))
    transparentCard.setRadius(dp2px(16))
    transparentCard.setElevation(0)
    transparentCard.setContentPadding(dp2px(16), dp2px(8), dp2px(16), dp2px(8))

    local transparentLayout = LinearLayout(activity)
    transparentLayout.setOrientation(LinearLayout.HORIZONTAL)
    transparentLayout.setGravity(Gravity.CENTER_VERTICAL)
    
    local transparentText = TextView(activity)
    transparentText.setText("悬浮窗背景透明")
    transparentText.setTextColor(COLOR_TEXT)
    transparentText.setTextSize(16)
    transparentText.setLayoutParams(LinearLayout.LayoutParams(-2, -2, 1))
    
    local transparentSwitch = MaterialSwitch(activity)
    transparentSwitch.setChecked(isFloatWindowTransparent)
    transparentSwitch.setLayoutParams(LinearLayout.LayoutParams(-2, -2))
    
    transparentSwitch.setOnCheckedChangeListener{
        onCheckedChanged = function(_, isChecked)
            isFloatWindowTransparent = isChecked
        end
    }
    
    transparentLayout.addView(transparentText)
    transparentLayout.addView(transparentSwitch)
    transparentCard.addView(transparentLayout)
    settingsView.addView(transparentCard)

    local space2 = View(activity)
    space2.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(8)))
    settingsView.addView(space2)

    -- Vulkan渲染设置项
    local vkRenderCard = MaterialCardView(activity)
    vkRenderCard.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(48)))
    vkRenderCard.setCardBackgroundColor(COLOR_CARD_BG)
    vkRenderCard.setStrokeColor(safeBorderColor)
    vkRenderCard.setStrokeWidth(dp2px(1))
    vkRenderCard.setRadius(dp2px(16))
    vkRenderCard.setElevation(0)
    vkRenderCard.setContentPadding(dp2px(16), dp2px(8), dp2px(16), dp2px(8))

    local vkRenderLayout = LinearLayout(activity)
    vkRenderLayout.setOrientation(LinearLayout.HORIZONTAL)
    vkRenderLayout.setGravity(Gravity.CENTER_VERTICAL)
    
    local vkRenderText = TextView(activity)
    vkRenderText.setText("使用Vulkan渲染")
    vkRenderText.setTextColor(COLOR_TEXT)
    vkRenderText.setTextSize(16)
    vkRenderText.setLayoutParams(LinearLayout.LayoutParams(-2, -2, 1))
    
    local vkRenderSwitch = MaterialSwitch(activity)
    vkRenderSwitch.setChecked(useVulkanRender)
    vkRenderSwitch.setLayoutParams(LinearLayout.LayoutParams(-2, -2))
    
    vkRenderSwitch.setOnCheckedChangeListener{
        onCheckedChanged = function(_, isChecked)
            useVulkanRender = isChecked
        end
    }
    
    vkRenderLayout.addView(vkRenderText)
    vkRenderLayout.addView(vkRenderSwitch)
    vkRenderCard.addView(vkRenderLayout)
    settingsView.addView(vkRenderCard)

    local space3 = View(activity)
    space3.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(8)))
    settingsView.addView(space3)

    -- 低性能模式设置项
    local lowPerfCard = MaterialCardView(activity)
    lowPerfCard.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(48)))
    lowPerfCard.setCardBackgroundColor(COLOR_CARD_BG)
    lowPerfCard.setStrokeColor(safeBorderColor)
    lowPerfCard.setStrokeWidth(dp2px(1))
    lowPerfCard.setRadius(dp2px(16))
    lowPerfCard.setElevation(0)
    lowPerfCard.setContentPadding(dp2px(16), dp2px(8), dp2px(16), dp2px(8))

    local lowPerfLayout = LinearLayout(activity)
    lowPerfLayout.setOrientation(LinearLayout.HORIZONTAL)
    lowPerfLayout.setGravity(Gravity.CENTER_VERTICAL)
    
    local lowPerfText = TextView(activity)
    lowPerfText.setText("低性能模式")
    lowPerfText.setTextColor(COLOR_TEXT)
    lowPerfText.setTextSize(16)
    lowPerfText.setLayoutParams(LinearLayout.LayoutParams(-2, -2, 1))
    
    local lowPerfSwitch = MaterialSwitch(activity)
    lowPerfSwitch.setChecked(isLowPerformanceMode)
    lowPerfSwitch.setLayoutParams(LinearLayout.LayoutParams(-2, -2))
    
    lowPerfSwitch.setOnCheckedChangeListener{
        onCheckedChanged = function(_, isChecked)
            isLowPerformanceMode = isChecked
        end
    }
    
    lowPerfLayout.addView(lowPerfText)
    lowPerfLayout.addView(lowPerfSwitch)
    lowPerfCard.addView(lowPerfLayout)
    settingsView.addView(lowPerfCard)

    local space4 = View(activity)
    space4.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(8)))
    settingsView.addView(space4)

    -- 灵动岛设置项
    local dynamicIslandCard = MaterialCardView(activity)
    dynamicIslandCard.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(48)))
    dynamicIslandCard.setCardBackgroundColor(COLOR_CARD_BG)
    dynamicIslandCard.setStrokeColor(safeBorderColor)
    dynamicIslandCard.setStrokeWidth(dp2px(1))
    dynamicIslandCard.setRadius(dp2px(16))
    dynamicIslandCard.setElevation(0)
    dynamicIslandCard.setContentPadding(dp2px(16), dp2px(8), dp2px(16), dp2px(8))

    local dynamicIslandLayout = LinearLayout(activity)
    dynamicIslandLayout.setOrientation(LinearLayout.HORIZONTAL)
    dynamicIslandLayout.setGravity(Gravity.CENTER_VERTICAL)

    local dynamicIslandText = TextView(activity)
    dynamicIslandText.setText("启用灵动岛")
    dynamicIslandText.setTextColor(COLOR_TEXT)
    dynamicIslandText.setTextSize(16)
    dynamicIslandText.setLayoutParams(LinearLayout.LayoutParams(-2, -2, 1))

    local dynamicIslandSwitch = MaterialSwitch(activity)
    dynamicIslandSwitch.setChecked(isDynamicIslandEnabled)
    dynamicIslandSwitch.setLayoutParams(LinearLayout.LayoutParams(-2, -2))

    dynamicIslandSwitch.setOnCheckedChangeListener{
        onCheckedChanged = function(_, isChecked)
            isDynamicIslandEnabled = isChecked
        end
    }

    dynamicIslandLayout.addView(dynamicIslandText)
    dynamicIslandLayout.addView(dynamicIslandSwitch)
    dynamicIslandCard.addView(dynamicIslandLayout)
    settingsView.addView(dynamicIslandCard)

    local space5 = View(activity)
    space5.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(8)))
    settingsView.addView(space5)

    -- 3D环绕音效设置项
    local surroundSoundCard = MaterialCardView(activity)
    surroundSoundCard.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(48)))
    surroundSoundCard.setCardBackgroundColor(COLOR_CARD_BG)
    surroundSoundCard.setStrokeColor(safeBorderColor)
    surroundSoundCard.setStrokeWidth(dp2px(1))
    surroundSoundCard.setRadius(dp2px(16))
    surroundSoundCard.setElevation(0)
    surroundSoundCard.setContentPadding(dp2px(16), dp2px(8), dp2px(16), dp2px(8))

    local surroundSoundLayout = LinearLayout(activity)
    surroundSoundLayout.setOrientation(LinearLayout.HORIZONTAL)
    surroundSoundLayout.setGravity(Gravity.CENTER_VERTICAL)
    
    local surroundSoundText = TextView(activity)
    surroundSoundText.setText("3D环绕音效")
    surroundSoundText.setTextColor(COLOR_TEXT)
    surroundSoundText.setTextSize(16)
    surroundSoundText.setLayoutParams(LinearLayout.LayoutParams(-2, -2, 1))
    
    local surroundSoundSwitch = MaterialSwitch(activity)
    surroundSoundSwitch.setChecked(surroundSoundEnabled)
    surroundSoundSwitch.setLayoutParams(LinearLayout.LayoutParams(-2, -2))
    
    surroundSoundSwitch.setOnCheckedChangeListener{
        onCheckedChanged = function(_, isChecked)
            surroundSoundEnabled = isChecked
        end
    }
    
    surroundSoundLayout.addView(surroundSoundText)
    surroundSoundLayout.addView(surroundSoundSwitch)
    surroundSoundCard.addView(surroundSoundLayout)
    settingsView.addView(surroundSoundCard)
    
    local space6 = View(activity)
    space6.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(8)))
    settingsView.addView(space6)

    -- 环绕速度设置项
    local speedCard = MaterialCardView(activity)
    speedCard.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(100)))
    speedCard.setCardBackgroundColor(COLOR_CARD_BG)
    speedCard.setStrokeColor(safeBorderColor)
    speedCard.setStrokeWidth(dp2px(1))
    speedCard.setRadius(dp2px(16))
    speedCard.setElevation(0)
    speedCard.setContentPadding(dp2px(16), dp2px(8), dp2px(16), dp2px(8))

    local speedLayout = LinearLayout(activity)
    speedLayout.setOrientation(LinearLayout.VERTICAL)
    
    local speedText = TextView(activity)
    speedText.setText("环绕速度: "..string.format("%.1f", surroundSoundSpeed))
    speedText.setTextColor(COLOR_TEXT)
    speedText.setTextSize(14)
    speedText.setLayoutParams(LinearLayout.LayoutParams(-1, -2))
    
    local speedSlider = Slider(activity)
    speedSlider.setValueFrom(0.5)
    speedSlider.setValueTo(4.0)
    speedSlider.setValue(surroundSoundSpeed)
    speedSlider.setStepSize(0.1)
    speedSlider.setLayoutParams(LinearLayout.LayoutParams(-1, -2))
    
    speedSlider.addOnChangeListener({
        onValueChange = function(slider, value, fromUser)
            surroundSoundSpeed = value
            speedText.setText("环绕速度: "..string.format("%.1f", value))
        end
    })
    
    speedLayout.addView(speedText)
    speedLayout.addView(speedSlider)
    speedCard.addView(speedLayout)
    settingsView.addView(speedCard)

    local space7 = View(activity)
    space7.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(8)))
    settingsView.addView(space7)

    -- 自定义背景设置项
    local bgSettingCard = MaterialCardView(activity)
    bgSettingCard.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(48)))
    bgSettingCard.setCardBackgroundColor(COLOR_CARD_BG)
    bgSettingCard.setStrokeColor(safeBorderColor)
    bgSettingCard.setStrokeWidth(dp2px(1))
    bgSettingCard.setRadius(dp2px(16))
    bgSettingCard.setElevation(0)
    bgSettingCard.setContentPadding(dp2px(16), dp2px(8), dp2px(16), dp2px(8))

    local bgSettingLayout = LinearLayout(activity)
    bgSettingLayout.setOrientation(LinearLayout.HORIZONTAL)
    bgSettingLayout.setGravity(Gravity.CENTER_VERTICAL)
    
    local bgSettingText = TextView(activity)
    bgSettingText.setText("自定义背景设置")
    bgSettingText.setTextColor(COLOR_TEXT)
    bgSettingText.setTextSize(16)
    bgSettingText.setLayoutParams(LinearLayout.LayoutParams(-2, -2, 1))
    
    local arrowText = TextView(activity)
    arrowText.setText(">")
    arrowText.setTextColor(COLOR_TEXT)
    arrowText.setTextSize(20)
    arrowText.setTypeface(Typeface.DEFAULT_BOLD)
    arrowText.setLayoutParams(LinearLayout.LayoutParams(-2, -2))
    
    bgSettingLayout.addView(bgSettingText)
    bgSettingLayout.addView(arrowText)
    
    bgSettingLayout.onClick = function()
        showBackgroundSettings()
    end
    
    bgSettingCard.addView(bgSettingLayout)
    settingsView.addView(bgSettingCard)

    local space8 = View(activity)
    space8.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(8)))
    settingsView.addView(space8)

    -- 关于本软件设置项
    local aboutCard = MaterialCardView(activity)
    aboutCard.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(48)))
    aboutCard.setCardBackgroundColor(COLOR_CARD_BG)
    aboutCard.setStrokeColor(safeBorderColor)
    aboutCard.setStrokeWidth(dp2px(1))
    aboutCard.setRadius(dp2px(16))
    aboutCard.setElevation(0)
    aboutCard.setContentPadding(dp2px(16), dp2px(8), dp2px(16), dp2px(8))

    local aboutLayout = LinearLayout(activity)
    aboutLayout.setOrientation(LinearLayout.HORIZONTAL)
    aboutLayout.setGravity(Gravity.CENTER_VERTICAL)
    
    local aboutIcon = ImageView(activity)
    aboutIcon.setImageBitmap(loadbitmap("res/gyblue.png"))
    aboutIcon.setColorFilter(COLOR_TEXT)
    aboutIcon.setScaleType(ImageView.ScaleType.FIT_CENTER)
    aboutIcon.setLayoutParams(LinearLayout.LayoutParams(dp2px(36), dp2px(36)))
    aboutIcon.setPadding(0, 0, dp2px(16), 0)
    
    local aboutText = TextView(activity)
    aboutText.setText("关于本软件")
    aboutText.setTextColor(COLOR_TEXT)
    aboutText.setTextSize(16)
    aboutText.setLayoutParams(LinearLayout.LayoutParams(-2, -2, 1))
    
    local arrowText2 = TextView(activity)
    arrowText2.setText(">")
    arrowText2.setTextColor(COLOR_TEXT)
    arrowText2.setTextSize(20)
    arrowText2.setTypeface(Typeface.DEFAULT_BOLD)
    arrowText2.setLayoutParams(LinearLayout.LayoutParams(-2, -2))
    
    aboutLayout.addView(aboutIcon)
    aboutLayout.addView(aboutText)
    aboutLayout.addView(arrowText2)
    
    aboutLayout.onClick = function()
        Quoid()
    end
    
    aboutCard.addView(aboutLayout)
    settingsView.addView(aboutCard)

    local space9 = View(activity)
    space9.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(8)))
    settingsView.addView(space9)

    -- 邮箱反馈设置项
    local feedbackCard = MaterialCardView(activity)
    feedbackCard.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(48)))
    feedbackCard.setCardBackgroundColor(COLOR_CARD_BG)
    feedbackCard.setStrokeColor(safeBorderColor)
    feedbackCard.setStrokeWidth(dp2px(1))
    feedbackCard.setRadius(dp2px(16))
    feedbackCard.setElevation(0)
    feedbackCard.setContentPadding(dp2px(16), dp2px(8), dp2px(16), dp2px(8))

    local feedbackLayout = LinearLayout(activity)
    feedbackLayout.setOrientation(LinearLayout.HORIZONTAL)
    feedbackLayout.setGravity(Gravity.CENTER_VERTICAL)
    
    local feedbackIcon = ImageView(activity)
    feedbackIcon.setImageBitmap(loadbitmap("res/yx.png"))
    feedbackIcon.setColorFilter(COLOR_TEXT)
    feedbackIcon.setScaleType(ImageView.ScaleType.FIT_CENTER)
    feedbackIcon.setLayoutParams(LinearLayout.LayoutParams(dp2px(36), dp2px(36)))
    feedbackIcon.setPadding(0, 0, dp2px(16), 0)
    
    local feedbackText = TextView(activity)
    feedbackText.setText("邮箱反馈")
    feedbackText.setTextColor(COLOR_TEXT)
    feedbackText.setTextSize(16)
    feedbackText.setLayoutParams(LinearLayout.LayoutParams(-2, -2, 1))
    
    local arrowText3 = TextView(activity)
    arrowText3.setText(">")
    arrowText3.setTextColor(COLOR_TEXT)
    arrowText3.setTextSize(20)
    arrowText3.setTypeface(Typeface.DEFAULT_BOLD)
    arrowText3.setLayoutParams(LinearLayout.LayoutParams(-2, -2))
    
    feedbackLayout.addView(feedbackIcon)
    feedbackLayout.addView(feedbackText)
    feedbackLayout.addView(arrowText3)
    
    feedbackLayout.onClick = function()
        showEmailFeedbackDialog()
    end
    
    feedbackCard.addView(feedbackLayout)
    settingsView.addView(feedbackCard)

    local spaceBeforeThemes = View(activity)
    spaceBeforeThemes.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(16)))
    settingsView.addView(spaceBeforeThemes)
    
    local themesTitle = TextView(activity)
    themesTitle.setText("选择主题")
    themesTitle.setTextColor(COLOR_TEXT)
    themesTitle.setTextSize(16)
    themesTitle.setTypeface(Typeface.DEFAULT_BOLD)
    themesTitle.setPadding(0, 0, 0, dp2px(8))
    settingsView.addView(themesTitle)

    -- 主题预览
    for i, theme in ipairs(themeColors) do
        local preview = createThemePreview(theme, i == currentThemeIndex)
        preview.setTag("theme_preview")
        preview.onClick = function()
            currentThemeIndex = i
            updateThemeColors()
            saveThemeSettings()
    
            local progressDialog = showThemeProgressDialog()
    
            Handler().postDelayed(Runnable{
                run = function()
                    progressDialog.getWindow().getDecorView().animate()
                    .alpha(0)
                    .setDuration(400)
                    .withEndAction(Runnable {
                        run = function()
                            progressDialog.dismiss()
                            updateThemeColors()
                            
                            local newMainView = loadlayout(createMainUI())
                            newMainView.setAlpha(0)
                            newMainView.setScaleX(0)
                            newMainView.setScaleY(0)
                            
                            activity.setContentView(newMainView)
                            
                            applyBackground()
                            
                            currentListType = currentListTypeBeforeSettings
                            searchResults = searchResultsBeforeSettings
                            favorites = favoritesBeforeSettings
                            
                            if currentListType == "search" and #searchResults > 0 then
                                adapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1)
                                for i, song in ipairs(searchResults) do
                                    adapter.add(song.name .. "\n" .. song.artist)
                                end
                                lvSongs.setAdapter(adapter)
                                tvListTitle.text = "搜索结果 (" .. #searchResults .. " 首)"
                            elseif currentListType == "favorites" and #favorites > 0 then
                                adapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1)
                                for i, fav in ipairs(favorites) do
                                    adapter.add(fav.name .. "\n" .. fav.artist)
                                end
                                lvSongs.setAdapter(adapter)
                                tvListTitle.text = "收藏列表 (" .. #favorites .. " 首)"
                            end
                            
                            Handler().postDelayed(Runnable{
                                run = function()
                                    newMainView.animate()
                                    .scaleX(1)
                                    .scaleY(1)
                                    .alpha(1)
                                    .setDuration(300)
                                    .start()
                                end
                            }, 500)
                            
                            setupEventListeners()
                            
                            if applyThemeToFloatWindow and isFloatingWindowOpen then
                                updateFloatingWindowTheme()
                            end
                        end
                    })
                    .start()
                end
            }, 1300)
        end
        preview.setOnTouchListener{
            onTouch = function(v, event)
                if event.action == MotionEvent.ACTION_DOWN then
                    v.animate().scaleX(0.95).scaleY(0.95).setDuration(100).start()
                 elseif event.action == MotionEvent.ACTION_UP or event.action == MotionEvent.ACTION_CANCEL then
                    v.animate().scaleX(1).scaleY(1).setDuration(100).start()
                end
                return false
            end
        }
        settingsView.addView(preview)
        
        if i ~= #themeColors then
            local space = View(activity)
            space.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(8)))
            settingsView.addView(space)
        end
    end
    
    local spaceAfterThemes = View(activity)
    spaceAfterThemes.setLayoutParams(LinearLayout.LayoutParams(-1, dp2px(16)))
    settingsView.addView(spaceAfterThemes)

    scrollView = ScrollView(activity)
    scrollView.addView(settingsView)
    
    local circleSize = dp2px(100)
    circleView = View(activity)
    circleView.setLayoutParams(LinearLayout.LayoutParams(circleSize, circleSize))
    
    local displayMetrics = activity.getResources().getDisplayMetrics()
    local centerX = (displayMetrics.widthPixels - circleSize) / 2
    local centerY = (displayMetrics.heightPixels - circleSize) / 2
    circleView.setX(centerX)
    circleView.setY(centerY)
    
    local shape = GradientDrawable()
    shape.setShape(GradientDrawable.OVAL)
    shape.setColor(0xFFFFFFFF)
    shape.setStroke(dp2px(2), safeBorderColor)
    circleView.setBackground(shape)
    circleView.setVisibility(View.INVISIBLE)
    
    rootLayout = FrameLayout(activity)
    rootLayout.setLayoutParams(FrameLayout.LayoutParams(-1, -1))
    rootLayout.addView(scrollView)
    rootLayout.addView(circleView)
    
    mainLayout.animate()
        .scaleX(0)
        .scaleY(0)
        .alpha(0)
        .setDuration(300)
        .setInterpolator(DecelerateInterpolator())
        .setListener({
            onAnimationStart = function()
                btnSettings.setEnabled(false)
                circleView.setVisibility(View.VISIBLE)
                circleView.setAlpha(1)
                circleView.setScaleX(1)
                circleView.setScaleY(1)
            end,
            onAnimationEnd = function()
                activity.setContentView(rootLayout)
                
                Handler().postDelayed(Runnable{
                    run = function()
                        local scaleFactor = math.max(
                            displayMetrics.widthPixels / circleSize,
                            displayMetrics.heightPixels / circleSize
                        ) * 1.5
                        
                        circleView.animate()
                            .scaleX(scaleFactor)
                            .scaleY(scaleFactor)
                            .alpha(0)
                            .setDuration(400)
                            .setInterpolator(AccelerateInterpolator(0.8))
                            .setListener({
                                onAnimationEnd = function()
                                    settingsView.setVisibility(View.VISIBLE)
                                    settingsView.animate()
                                        .alpha(1)
                                        .setDuration(200)
                                        .start()
                                end
                            })
                            .start()
                    end
                }, 0)
            end
        })
        .start()
end


function Quoid()
    local dialogBuilder = AlertDialog.Builder(activity)
    dialogBuilder.setCancelable(false)

    local mainLayout = RelativeLayout(activity)
    mainLayout.setPadding(dp2px(16), dp2px(16), dp2px(16), dp2px(16))

    local closeBtn = TextView(activity)
    closeBtn.setText("×")
    closeBtn.setTextSize(30)
    closeBtn.setTextColor(0xFF888888)
    local btnParams = RelativeLayout.LayoutParams(
        RelativeLayout.LayoutParams.WRAP_CONTENT,
        RelativeLayout.LayoutParams.WRAP_CONTENT
    )
    btnParams.addRule(RelativeLayout.ALIGN_PARENT_RIGHT)
    closeBtn.setLayoutParams(btnParams)
    closeBtn.setPadding(dp2px(16), 0, 0, dp2px(16))

    closeBtn.onClick = function()
        if alertDialog and alertDialog.isShowing() then
            alertDialog.dismiss()
            全屏()
        end
    end
    mainLayout.addView(closeBtn)

    local contentLayout = LinearLayout(activity)
    contentLayout.setOrientation(LinearLayout.VERTICAL)
    local contentParams = RelativeLayout.LayoutParams(-1, -1)
    contentParams.addRule(RelativeLayout.CENTER_IN_PARENT)
    contentLayout.setLayoutParams(contentParams)
    contentLayout.setPadding(0, dp2px(40), 0, 0)

    local titleText = TextView(activity)
    titleText.setText("关于 blue Aurora")
    titleText.setTextSize(20)
    titleText.setTextColor(COLOR_TEXT)
    titleText.setTypeface(Typeface.DEFAULT_BOLD)
    titleText.setGravity(Gravity.CENTER)
    titleText.setLayoutParams(LinearLayout.LayoutParams(-1, -2))
    titleText.setPadding(0, 0, 0, dp2px(16))
    contentLayout.addView(titleText)

    local contentText = [[
blue Aurora 是一款轻简约音乐播放器,后续将会更完善便捷。

介绍更新日期: 2025年7月18日

所有功能介绍
1. Vulkan渲染
- 使用Vulkan(VK)实现高效界面渲染
- 降低负载，提升整体流畅度
- 支持高帧率显
- 功耗优化，延长设备续航时间

2. 透明悬浮窗
- 支持自由开关

3. 自定义
- 5种精心设计的全局主题配色
- 背景图片支持全尺寸导入
- 内有高斯模糊强度支持多级调节
- 支持卡片透明度调节


优化
• 内存占用控制在200MB以内
• 0.5秒冷启动速度
• 高效低耗电

非闭源
可放心使用
开源平台:GitHub
开源协议:GNU General Public License version 3.0 (GPLv3)
获取方式:自行平台搜索

所有的反馈，如果可行都会采纳

个人开发所以有很多不足,可以自行反馈。
(2022-2025) © 青
    ]]

    local textView = TextView(activity)
    textView.setLayoutParams(LinearLayout.LayoutParams(-1, -1))
    textView.setText(contentText)
    textView.setTextColor(COLOR_TEXT)
    textView.setTextSize(14)
    textView.setLineSpacing(dp2px(4), 1)
    contentLayout.addView(textView)
    mainLayout.addView(contentLayout)

    dialogBuilder.setView(mainLayout)

    local bg = GradientDrawable()
    bg.setColor(COLOR_CARD_BG)
    bg.setCornerRadius(dp2px(20))
    bg.setStroke(dp2px(1), COLOR_BORDER)


    alertDialog = dialogBuilder.show()
    local window = alertDialog.getWindow()
    window.setBackgroundDrawable(bg)

    local layoutParams = window.getAttributes()
    layoutParams.width = WindowManager.LayoutParams.MATCH_PARENT
    layoutParams.height = WindowManager.LayoutParams.MATCH_PARENT
    window.setAttributes(layoutParams)
    alertDialog.setCancelable(false)
    alertDialog.setCanceledOnTouchOutside(false)

    alertDialog.setOnDismissListener({
        onDismiss = function()
            全屏()
        end
    })
end

function setupEventListeners()
    if isDynamicIslandEnabled and Settings.canDrawOverlays(activity) and not dynamicIsland then
        dynamicIsland = createDynamicIsland()
        dynamicIsland.setOnPlayClick(function()
            togglePlayPause()
        end)

        dynamicIsland.setOnPrevClick(function()
            if currentSong == nil then return end
            
            if currentSource == "float" and #xfqsongs > 0 then
                local currentIndex = 0
                for i, song in ipairs(xfqsongs) do
                    if song.id == currentSong.id then
                        currentIndex = i
                        break
                    end
                end
                local prevIndex = currentIndex - 1
                if prevIndex < 1 then prevIndex = #xfqsongs end
                local prevSong = xfqsongs[prevIndex]
                prevSong.source = "float"
                playMusic(prevSong)
                
            elseif currentSource == "search" and #searchResults > 0 then
                local currentIndex = 0
                for i, song in ipairs(searchResults) do
                    if song.id == currentSong.id then
                        currentIndex = i
                        break
                    end
                end
                local prevIndex = currentIndex - 1
                if prevIndex < 1 then prevIndex = #searchResults end
                local prevSong = searchResults[prevIndex]
                prevSong.source = "search"
                playMusic(prevSong)
                
            elseif currentSource == "favorites" and #favorites > 0 then
                local currentIndex = 0
                for i, song in ipairs(favorites) do
                    if song.id == currentSong.id then
                        currentIndex = i
                        break
                    end
                end
                local prevIndex = currentIndex - 1
                if prevIndex < 1 then prevIndex = #favorites end
                local prevSong = favorites[prevIndex]
                prevSong.source = "favorites"
                playMusic(prevSong)
            end
        end)
        
        dynamicIsland.setOnNextClick(function()
            if currentSong == nil then return end

            if currentSource == "float" and #xfqsongs > 0 then
                local currentIndex = 0
                for i, song in ipairs(xfqsongs) do
                    if song.id == currentSong.id then
                        currentIndex = i
                        break
                    end
                end
                local nextIndex = currentIndex + 1
                if nextIndex > #xfqsongs then nextIndex = 1 end
                local nextSong = xfqsongs[nextIndex]
                nextSong.source = "float"
                playMusic(nextSong)
                
            elseif currentSource == "search" and #searchResults > 0 then
                local currentIndex = 0
                for i, song in ipairs(searchResults) do
                    if song.id == currentSong.id then
                        currentIndex = i
                        break
                    end
                end
                local nextIndex = currentIndex + 1
                if nextIndex > #searchResults then nextIndex = 1 end
                local nextSong = searchResults[nextIndex]
                nextSong.source = "search"
                playMusic(nextSong)
                
            elseif currentSource == "favorites" and #favorites > 0 then
                local currentIndex = 0
                for i, song in ipairs(favorites) do
                    if song.id == currentSong.id then
                        currentIndex = i
                        break
                    end
                end
                local nextIndex = currentIndex + 1
                if nextIndex > #favorites then nextIndex = 1 end
                local nextSong = favorites[nextIndex]
                nextSong.source = "favorites"
                playMusic(nextSong)
            end
        end)
        
        dynamicIsland.hide()
    end

    local originalPlayMusic = playMusic
    playMusic = function(entry)
        if not entry.source then
            for _, song in ipairs(xfqsongs) do
                if song.id == entry.id then
                    entry.source = "float"
                    break
                end
            end
            
            if not entry.source then
                for _, song in ipairs(favorites) do
                    if song.id == entry.id then
                        entry.source = "favorites"
                        break
                    end
                end
            end
            entry.source = entry.source or "search"
        end
        
        currentSource = entry.source
        
        originalPlayMusic(entry)
    end

    xfq_lvSongs.setOnItemClickListener(AdapterView.OnItemClickListener{
        onItemClick = function(parent, view, position, id)
            local index = position + 1
            if index <= #xfqsongs then
                local entry = xfqsongs[index]
                entry.source = "float"
                playMusic(entry)
                xfq_nowPlaying.text = "正在播放: " .. entry.name .. " - " .. entry.artist
                if xfq_btnPlay then
                    xfq_btnPlay.text = "暂停"
                end
            end
        end
    })

    --搜索/收藏列表点击事件
    lvSongs.onItemClick = function(parent, view, position, id)
        local index = position + 1
        if currentListType == "search" and index <= #searchResults then
            local song = searchResults[index]
            song.source = "search"
            playMusic(song)
        elseif currentListType == "favorites" and index <= #favorites then
            local song = favorites[index]
            song.source = "favorites"
            playMusic(song)
        end
    end

    if #savedSongs > 0 then
        songs = savedSongs
        adapter.clear()
        for i, song in ipairs(songs) do
            adapter.add(song.name .. "\n" .. song.artist)
        end
        lvSongs.setAdapter(adapter)
    end

    if isLooping then
        btnLoop.setImageBitmap(loadbitmap("kyxh.png"))
    else
        btnLoop.setImageBitmap(loadbitmap("gbzt.png"))
    end

    btnLoop.onClick = function()
        toggleLooping()
    end

    lvSongs.setOnTouchListener(View.OnTouchListener{
        onTouch = function(v, event)
            lastTouchX = event.getRawX()
            lastTouchY = event.getRawY()
            return false
        end
    })

    btnHistory.onClick = function()
        showHistoryDialog()
    end
    
    btnSearch.onClick = function()
        searchMusic(etSearch.text)
    end
    
    etSearch.onEditorAction = function(v, actionId, event)
        if actionId == EditorInfo.IME_ACTION_SEARCH then
            searchMusic(etSearch.text)
            return true
        end
        return false
    end
    
    lvSongs.setOnItemLongClickListener(AdapterView.OnItemLongClickListener{
        onItemLongClick = function(parent, view, position, id)
            local index = position + 1
            local entry
            if currentListType == "search" and index <= #searchResults then
                entry = searchResults[index]
                entry.source = "search"
            elseif currentListType == "favorites" and index <= #favorites then
                entry = favorites[index]
                entry.source = "favorites"
            end
            
            if entry then
                if lastTouchX and lastTouchY then
                    showSongMenu(entry, lastTouchX, lastTouchY, currentListType == "favorites")
                else
                    local location = {0, 0}
                    view.getLocationOnScreen(location)
                    local x = location[1] + view.getWidth()/2
                    local y = location[2] + view.getHeight()/2
                    showSongMenu(entry, x, y, currentListType == "favorites")
                end
            end
            return true
        end
    })
    
    btnFloat.onClick = function()
        if not ensureOverlayPermission() then return end
        if not isFloatingWindowOpen and not isFloatingBallVisible then
            floatingBall.setAlpha(0.0)
            wm.addView(floatingBall, wmParamsBall)
            isFloatingBallVisible = true
            floatingBall.animate()
            .alpha(1.0)
            .setDuration(300)
            .start()
        elseif isFloatingWindowOpen then
            xfq_btnClose.onClick(nil)
        else
            showFloatingWindow()
        end
    end
    
    btnImport.onClick = function()
        importNeteasePlaylist()
    end
    
    btnSettings.onClick = function()
        showThemeSelection()
    end
    
    btnPlay.onClick = function()
        togglePlayPause()
    end
    
    btnFavorites.onClick = function()
        if isListAnimating then return end
        isListAnimating = true

        lvSongs.animate()
        .alpha(0)
        .translationYBy(dp2px(20))
        .setDuration(300)
        .withEndAction(Runnable({
            run = function()
                if currentListType == "search" then
                    favorites = loadFavorites()
                    if #favorites == 0 then
                        Toast.makeText(activity, "收藏列表为空", Toast.LENGTH_SHORT).show()
                        lvSongs.animate().alpha(1).translationYBy(-dp2px(20)).setDuration(300).withEndAction(Runnable({
                            run = function()
                                isListAnimating = false
                            end
                        })).start()
                        return
                    end

                    currentListType = "favorites"
                    btnFavorites.text = "返回搜索列表"

                    tvListTitle.text = "收藏列表 (" .. #favorites .. " 首)"

                    local favAdapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1)
                    for i, fav in ipairs(favorites) do
                        favAdapter.add(fav.name .. "\n" .. fav.artist)
                    end
                    lvSongs.setAdapter(favAdapter)
                    songs = favorites
                    tvStatus.text = "收藏列表 (" .. #favorites .. " 首)"
                else
                    currentListType = "search"
                    btnFavorites.text = "收藏列表"

                    if #searchResults > 0 then
                        tvListTitle.text = "搜索结果 (" .. #searchResults .. " 首)"
                    else
                        tvListTitle.text = "搜索结果"
                    end

                    if #searchResults > 0 then
                        songs = searchResults
                        adapter.clear()
                        for i, song in ipairs(songs) do
                            adapter.add(song.name .. "\n" .. song.artist)
                        end
                        lvSongs.setAdapter(adapter)
                        tvStatus.text = "搜索列表 (" .. #songs .. " 首)"
                    else
                        adapter.clear()
                        tvStatus.text = "无搜索结果"
                    end
                end

                lvSongs.setAlpha(0)
                lvSongs.setTranslationY(dp2px(-20))
                lvSongs.animate()
                .alpha(1)
                .translationY(0)
                .setDuration(400)
                .withEndAction(Runnable({
                    run = function()
                        isListAnimating = false
                    end
                }))
                .start()
            end
        }))
        .start()
    end
    
    pbSong.setOnTouchListener({
        onTouch = function(v, event)
            if currentSong and mediaPlayer then
                local action = event.getAction()
                if action == MotionEvent.ACTION_DOWN then
                    updateProgressHandler.removeCallbacks(updateProgressRunnable)
                    return true
                elseif action == MotionEvent.ACTION_MOVE then
                    local x = event.getX()
                    local width = v.getWidth()
                    local ratio = x / width
                    if ratio < 0 then ratio = 0 end
                    if ratio > 1 then ratio = 1 end
                    local prog = math.floor(ratio * 1000)
                    pbSong.setProgress(prog)
                    if xfq_pbSong then
                        xfq_pbSong.setProgress(prog)
                    end
                    if mediaPlayer.getDuration() > 0 then
                        tvCurrentTime.text = formatTime(math.floor(ratio * mediaPlayer.getDuration()))
                        if xfq_tvCurrentTime then
                            xfq_tvCurrentTime.text = formatTime(math.floor(ratio * mediaPlayer.getDuration()))
                        end
                    end
                    return true
                elseif action == MotionEvent.ACTION_UP then
                    local x = event.getX()
                    local width = v.getWidth()
                    local ratio = x / width
                    if ratio < 0 then ratio = 0 end
                    if ratio > 1 then ratio = 1 end
                    if not mediaPlayer.isPlaying() and not isPlaying then
                        isPlaying = true
                        if btnPlay then
                            btnPlay.text = "暂停"
                        end
                        if xfq_btnPlay then
                            xfq_btnPlay.text = "暂停"
                        end
                    end
                    if mediaPlayer.getDuration() > 0 then
                        local seekPos = math.floor(ratio * mediaPlayer.getDuration())
                        mediaPlayer.seekTo(seekPos)
                        if not mediaPlayer.isPlaying() then
                            mediaPlayer.start()
                        end
                        pbSong.setProgress(math.floor(ratio * 1000))
                        if xfq_pbSong then
                            xfq_pbSong.setProgress(math.floor(ratio * 1000))
                        end
                        tvCurrentTime.text = formatTime(seekPos)
                        if xfq_tvCurrentTime then
                            xfq_tvCurrentTime.text = formatTime(seekPos)
                        end
                        tvStatus.text = "正在播放: " .. currentSong.name
                    end
                    if isPlaying then
                        updateProgressHandler.post(updateProgressRunnable)
                    end
                    return true
                end
            end
            return false
        end
    })
end

setupEventListeners()

function onActivityResult(requestCode, resultCode, data)
  if requestCode == 100 and resultCode == Activity.RESULT_OK and data then
    local uri = data.getData()
    if uri then
      local input = activity.getContentResolver().openInputStream(uri)
      local options = BitmapFactory.Options()
      options.inSampleSize = 2
      local bitmap = BitmapFactory.decodeStream(input, nil, options)
      input.close()

      if bitmap then
        local scale = math.min(screenWidth / bitmap.getWidth(), screenHeight / bitmap.getHeight())
        local width = math.floor(bitmap.getWidth() * scale)
        local height = math.floor(bitmap.getHeight() * scale)
        
        local scaledBitmap = Bitmap.createScaledBitmap(bitmap, width, height, true)
        
        local filename = "background_" .. os.time() .. ".jpg"
        local destPath = bgDir .. "/" .. filename
        local dest = FileOutputStream(File(destPath))
        scaledBitmap.compress(Bitmap.CompressFormat.JPEG, 90, dest)
        dest.close()

        bgImagePath = destPath
        loadAndCacheBackground()
        Toast.makeText(activity, "背景图片已设置", Toast.LENGTH_SHORT).show()
        applyBackground()
      end
    end
  end
end

function onDestroy()
    if mediaPlayer then
        mediaPlayer.release()
        mediaPlayer = nil
    end
    if wm and isFloatingWindowOpen then
        wm.removeView(floatingWindow)
    end
    if wm and isFloatingBallVisible then
        wm.removeView(floatingBall)
    end
    updateProgressHandler.removeCallbacks(updateProgressRunnable)
    if dynamicIsland then
        dynamicIsland.destroy()
        dynamicIsland = nil
    end
    if renderScript then
        renderScript.destroy()
        renderScript = nil
    end
  end