require "import"
import "android.widget.*"
import "android.view.*"
import "android.text.TextUtils"
import "android.graphics.drawable.*"
import "android.graphics.*"
import "android.os.Handler"
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.style.StyleSpan"
import "android.graphics.Typeface"
import "android.content.res.ColorStateList"
import "android.view.inputmethod.EditorInfo"
import "com.google.android.material.color.MaterialColors"
import "com.google.android.material.shape.MaterialShapeDrawable"
import "com.google.android.material.shape.CornerFamily"
import "com.google.android.material.shape.ShapeAppearanceModel"
import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.textfield.TextInputLayout"
import "com.google.android.material.textfield.TextInputEditText"
import "com.google.android.material.button.MaterialButton"
import "com.androlua.Http"
import "android.app.*"
import "android.os.*"
import "androidx.appcompat.widget.LinearLayoutCompat"
import "android.view.MotionEvent"
import "android.media.MediaPlayer"
import "android.content.*"
import "android.net.Uri"
import "android.provider.Settings"
import "android.util.DisplayMetrics"
import "android.view.inputmethod.InputMethodManager"
import "android.text.util.Linkify"
import "android.text.style.URLSpan"
import "android.text.method.LinkMovementMethod"
import "json"
import "com.google.android.material.materialswitch.MaterialSwitch"
import "com.google.android.material.progressindicator.CircularProgressIndicator"
import "android.app.AlertDialog"
import "android.graphics.Color"
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
import "android.os.Build"
import "android.content.Context"
import "android.animation.ValueAnimator"
import "android.animation.AnimatorSet"
import "android.animation.ObjectAnimator"
import "android.animation.TimeInterpolator"
import "android.animation.Animator"
import "android.content.res.Configuration"
import "android.media.AudioManager"
import "android.media.AudioAttributes"
import "com.google.android.material.dialog.MaterialAlertDialogBuilder"
import "android.graphics.Color"
import "android.text.SpannableString"
import "android.text.util.Linkify"
import "android.text.method.LinkMovementMethod"
import "android.text.style.LeadingMarginSpan"
import "android.text.SpannableStringBuilder"

activity
.setTheme(R.style.Theme_Material3_Blue)
.setTitle("blue AI")
.setContentView(loadlayout("layout"))

-- 隐藏ActionBar
if activity.getSupportActionBar() ~= nil then
    activity.getSupportActionBar().hide()
end

-- 全屏
function blueFullScreen()
  window = activity.getWindow()
  window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_FULLSCREEN|View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN)
  window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
  xpcall(function()
    lp = window.getAttributes()
    lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES
    window.setAttributes(lp)
  end,
  function(e)
  end)
end


--blueFullScreen() 暂时弃用因为会影响输入框

--由于未完善暂时使用固定颜色
local blueColorScheme = {
    primary = Color.parseColor("#7FB8FF"),  
    onPrimary = Color.parseColor("#FFFFFF"), 
    primaryContainer = Color.parseColor("#D4E9FF"), 
    onPrimaryContainer = Color.parseColor("#1A4D80"), 
    secondary = Color.parseColor("#A3C8FF"), 
    onSecondary = Color.parseColor("#003366"),
    secondaryContainer = Color.parseColor("#E6F2FF"), 
    onSecondaryContainer = Color.parseColor("#336699"),
    surface = Color.parseColor("#F5F9FF"), 
    onSurface = Color.parseColor("#003366"), 
    surfaceVariant = Color.parseColor("#E6F2FF"), 
    onSurfaceVariant = Color.parseColor("#4D7CB3"), 
    outline = Color.parseColor("#B3D9FF"), 
    outlineVariant = Color.parseColor("#D4E9FF"), 
    cardBg = Color.parseColor("#FFFFFF"), 
    onCardBg = Color.parseColor("#003366"),
    error = Color.parseColor("#FF6B6B"), 
    onError = Color.parseColor("#FFFFFF"), 
    errorContainer = Color.parseColor("#FFE5E5"), 
    onErrorContainer = Color.parseColor("#CC3333"), 
    iconPrimary = Color.parseColor("#7FB8FF"), 
    iconSecondary = Color.parseColor("#A3C8FF"),  
    iconOnSurface = Color.parseColor("#003366"), 
    iconOnPrimary = Color.parseColor("#FFFFFF") 
}

-- 情绪颜色映射
local blueMoodColors = {
    normal = blueColorScheme.primary,
    angry = blueColorScheme.error,
    happy = Color.parseColor("#0D921B"),
    sad = blueColorScheme.tertiary
}

-- 角色定义
local blueCharacters = {
    {
        name = "亚历山大·李",
        age = "38岁",
        description = [[
【身份背景】
前特种部队狙击手，现废土幸存者小队"铁锈"队长。]],
        mood = "normal",
        killCount = math.random(10,50),
        injuryCount = math.random(0,5),
        daySurvived = math.random(10,100),
        companions = {
            "陈默(你)：前医学院学生",
            "白鸽：前黑客",
            "老枪：前机械师"
        },
        currentStatus = {
            "基地物资：勉强维持",
            "变异体威胁等级：黄色警戒",
            "最近事件：发现北方有神秘信号源"
        }
    },
    {
        name = "维克多·陈",
        age = "45岁",
        description = [[
【身份背景】
前生物实验室首席科学家，现幸存者聚居地技术主管。]],
        mood = "normal",
        researchProgress = math.random(30,70),
        infectionRisk = math.random(5,20),
        daySurvived = math.random(10,100),
        assistants = {
            "张伟(你)：前医学院实习生",
            "艾玛：前药剂师",
            "伊万：前实验室技术员"
        },
        currentStatus = {
            "疫苗研发进度："..math.random(30,70).."%",
            "实验室安全等级：B级",
            "最近发现：变异病毒出现新亚种"
        }
    },
    {
        name = "尼古拉斯·王",
        age = "29岁",
        description = [[
【身份背景】
前赛车手兼机械天才，现为流浪商人车队首领。]],
        mood = "normal",
        tradeProfit = math.random(-10,50),
        routeSafety = math.random(40,90),
        daySurvived = math.random(10,100),
        crew = {
            "李明(你)：前会计",
            "露西：前保镖",
            "汤姆：前汽修工"
        },
        currentStatus = {
            "当前货物价值："..math.random(100,500).."信用点",
            "下个目的地：北方前哨站",
            "最近事件：遭遇掠夺者伏击但成功逃脱"
        }
    }
}

-- 当前角色索引
local blueCurrentCharacterIndex = 1
local blueCharacterData = blueCharacters[blueCurrentCharacterIndex]

-- 全局Handler
local blueHandler = Handler()

-- 获取聊天文件路径
local function blueGetChatFilePath()
    return activity.getExternalFilesDir(nil).toString().."/chat_"..blueCurrentCharacterIndex..".txt"
end

-- 加载聊天记录
local function blueLoadChatHistory()
    local chatHistory = {}
    local file = File(blueGetChatFilePath())
    if file.exists() then
        local br = BufferedReader(FileReader(file))
        local line
        while true do
            line = br.readLine()
            if line == nil then break end
            local isUser = line:sub(1,1) == "1"
            local content = line:sub(2)
            table.insert(chatHistory, {isUser=isUser, content=content})
        end
        br.close()
    end
    return chatHistory
end

-- 保存聊天消息
local function blueSaveChatMessage(isUser, content)
    local file = FileWriter(blueGetChatFilePath(), true)
    file.write((isUser and "1" or "0")..content.."\n")
    file.close()
end

-- 清空聊天记录
local function blueClearCurrentChatHistory()
    local file = File(blueGetChatFilePath())
    if file.exists() then
        file.delete()
    end
end

-- 关键词库
local blueTriggerWords = {
    "变异体","感染者","尸潮","掠夺者","物资","药品","电池","燃料","安全区","污染区",
    "绝望","希望","信任","背叛","回忆","家人","侦查","防守","突围","撤离"
}

-- 检查文本触发类型
local function blueCheckTextTriggers(text)
    local triggers = {
        angry = false,
        happy = false,
        sad = false,
        special = ""
    }
    
    local lowerText = text:lower()
    
    for _, word in ipairs(blueTriggerWords) do
        if lowerText:find(word:lower()) then
            if word == "尸潮" or word == "掠夺者" then
                triggers.angry = true
                triggers.special = "danger_alert"
            elseif word == "物资" or word == "安全区" then
                triggers.happy = true
                triggers.special = "found_supplies"
            elseif word == "家人" or word == "回忆" then
                triggers.sad = true
            elseif word == "变异体" then
                triggers.angry = true
                triggers.special = "mutant_encounter"
                if blueCharacterData.killCount then
                    blueCharacterData.killCount = blueCharacterData.killCount + math.random(1,3)
                end
            else
                triggers.angry = true
            end
        end
    end
    
    if blueCharacterData.daySurvived then
        blueCharacterData.daySurvived = blueCharacterData.daySurvived + 1
    end
    
    return triggers
end

-- dp转px
function blueDp2px(dpValue)
    return tonumber(dpValue) * activity.getResources().getDisplayMetrics().density
end

-- 创建消息气泡背景
function blueCreateBubbleBackground(isUser, color)
    local builder = ShapeAppearanceModel.builder()
    
    if isUser then
        builder.setAllCorners(CornerFamily.ROUNDED, blueDp2px(12))
            .setTopRightCorner(CornerFamily.ROUNDED, blueDp2px(4))
    else
        builder.setAllCorners(CornerFamily.ROUNDED, blueDp2px(12))
            .setTopLeftCorner(CornerFamily.ROUNDED, blueDp2px(4))
    end
    
    local shape = MaterialShapeDrawable(builder.build())
    shape.setFillColor(ColorStateList.valueOf(color))
    shape.setTint(color)
    return shape
end

-- 打字机效果
function blueTypewriterEffect(textView, text, callback)
    if text == nil then text = "" end
    local fullText = tostring(text)
    local i = 0
    local delay = 30
    
    textView.setText("")
    
    local function addChar()
        i = i + 1
        if i <= #fullText then
            textView.setText(fullText:sub(1, i))
            blueHandler.postDelayed(addChar, delay)
        elseif callback then 
            callback()
        end
    end
    
    addChar()
end

-- URL编码
local function blueUrlEncode(str)
    if str == nil then return "" end
    str = string.gsub(str, "([^%w ])", function (c)
        return string.format("%%%02X", string.byte(c))
    end)
    str = string.gsub(str, " ", "+")
    return str
end

-- 构建对话上下文
local function blueBuildConversationContext(input)
    local context = blueCharacterData.description.."\n\n"
    
    if blueCharacterData.currentStatus then
        context = context .. "【当前状态】\n"
        for _, status in ipairs(blueCharacterData.currentStatus) do
            context = context .. "- "..status.."\n"
        end
        context = context .. "\n"
    end
    
    if blueCharacterData.companions then
        context = context .. "【团队成员】\n"
        for _, member in ipairs(blueCharacterData.companions) do
            context = context .. "- "..member.."\n"
        end
    elseif blueCharacterData.assistants then
        context = context .. "【助手团队】\n"
        for _, assistant in ipairs(blueCharacterData.assistants) do
            context = context .. "- "..assistant.."\n"
        end
    elseif blueCharacterData.crew then
        context = context .. "【车队成员】\n"
        for _, member in ipairs(blueCharacterData.crew) do
            context = context .. "- "..member.."\n"
        end
    end
    
    context = context .. "\n当前情绪: " .. blueCharacterData.mood .. "\n"
    if blueCharacterData.killCount then
        context = context .. "击杀变异体: " .. blueCharacterData.killCount .. "\n"
    end
    if blueCharacterData.researchProgress then
        context = context .. "研究进度: " .. blueCharacterData.researchProgress .. "%\n"
    end
    if blueCharacterData.tradeProfit then
        context = context .. "交易利润: " .. blueCharacterData.tradeProfit .. "信用点\n"
    end
    context = context .. "存活天数: " .. blueCharacterData.daySurvived .. "\n\n"
    
    local chatHistory = blueLoadChatHistory()
    if #chatHistory > 0 then
        context = context .. "【近期对话】\n"
        for i = math.max(1, #chatHistory-4), #chatHistory do
            local msg = chatHistory[i]
            context = context .. (msg.isUser and "你: " or blueCharacterData.name..": ")..msg.content.."\n"
        end
        context = context .. "\n"
    end
    
    context = context .. "你对"..blueCharacterData.name.."说: \"" .. input .. "\""
    
    return context
end

-- 调用AI接口
local function blueAI(input, callback)
    local triggers = blueCheckTextTriggers(input)
    
    if triggers.angry then
        blueCharacterData.mood = "angry"
        if triggers.special == "mutant_encounter" and blueCharacterData.injuryCount then
            blueCharacterData.injuryCount = blueCharacterData.injuryCount + math.random(0,1)
        end
    elseif triggers.happy then
        blueCharacterData.mood = "happy"
        if triggers.special == "found_supplies" then
            blueCharacterData.daySurvived = blueCharacterData.daySurvived + math.random(1,3)
        end
    elseif triggers.sad then
        blueCharacterData.mood = "sad"
    else
        blueCharacterData.mood = "normal"
    end
    
    local prompt = blueBuildConversationContext(input)
    
    local systemPrompt = [[
你正在扮演]]..blueCharacterData.name..[[，一位在末日废土中生存的角色。]]
    
    callback(true)
    
    local params = {
        question = input,
        system = systemPrompt
    }
    
    local headers = {
        ["Content-Type"] = "application/x-www-form-urlencoded"
    }
    
    Http.post("https://api.jkyai.top/API/gemini2.5.php", params, headers, function(code, content)
        if code == 200 and content and content ~= "" then
            content = content:gsub("^"..blueCharacterData.name..":", "")
            content = content:gsub("^AI:", "")
            content = content:gsub("\n", "")
            
            if content == "" then
                if blueCharacterData.mood == "angry" then
                    content = "保持警戒！这区域不安全。[检查装备]"
                elseif blueCharacterData.mood == "happy" then
                    content = "这是个好消息，但我们不能放松警惕。"
                elseif blueCharacterData.mood == "sad" then
                    content = "...现在不是回忆的时候，继续任务吧。"
                else
                    content = "收到。继续执行计划。"
                end
            end
            
            blueSaveChatMessage(false, content)
            callback(false, content)
        else
            local fallback = "通讯中断！[检查设备并尝试重新连接]"
            blueSaveChatMessage(false, fallback)
            callback(false, fallback)
        end
    end)
end

-- 切换角色
local function blueSwitchCharacter(index)
    blueCurrentCharacterIndex = index
    blueCharacterData = blueCharacters[blueCurrentCharacterIndex]
    
    nameText.setText(blueCharacterData.name)
    descText.setText(blueCharacterData.age .. " | "..(
        index == 1 and "幸存者队长" or 
        index == 2 and "科学家" or 
        "商人首领"
    ))
    
    if index == 1 then
        stat1Text.setText("击杀: "..blueCharacterData.killCount)
        stat2Text.setText("受伤: "..blueCharacterData.injuryCount)
    elseif index == 2 then
        stat1Text.setText("研究: "..blueCharacterData.researchProgress.."%")
        stat2Text.setText("风险: "..blueCharacterData.infectionRisk.."%")
    else
        stat1Text.setText("利润: "..blueCharacterData.tradeProfit)
        stat2Text.setText("安全: "..blueCharacterData.routeSafety.."%")
    end
    
    moodText.setText("情绪: "..blueCharacterData.mood)
    moodText.setTextColor(blueMoodColors[blueCharacterData.mood])
end

-- 创建角色选择对话框
local function blueCreateCharacterDialog()
    local dialog = LinearLayout(activity)
    dialog.setLayoutParams(LinearLayout.LayoutParams(blueDp2px(280), -2))
    dialog.setBackgroundColor(blueColorScheme.surface)
    dialog.setOrientation(1)
    dialog.setPadding(blueDp2px(16), blueDp2px(16), blueDp2px(16), blueDp2px(16))
    dialog.setElevation(0)
    
    local title = TextView(activity)
    title.setText("选择对话角色")
    title.setTextSize(18)
    title.setTextColor(blueColorScheme.onSurface)
    title.setTypeface(nil, Typeface.BOLD)
    title.setPadding(0, 0, 0, blueDp2px(16))
    dialog.addView(title)
    
    local characterOptions = {
        {name = "军人 - 亚历山大·斯托克", index = 1},
        {name = "科学家 - 维克多·托尼", index = 2},
        {name = "商人 - 尼古拉斯·王", index = 3}
    }
    
    for i, option in ipairs(characterOptions) do
        local btn = MaterialButton(activity)
        local params = LinearLayout.LayoutParams(-1, -2)
        params.bottomMargin = blueDp2px(8)
        btn.setLayoutParams(params)
        btn.setText(option.name)
        btn.setTextColor(blueColorScheme.onPrimary)
        btn.setBackgroundColor(blueColorScheme.primary)
        btn.setCornerRadius(blueDp2px(8))
        btn.setPadding(blueDp2px(16), blueDp2px(12), blueDp2px(16), blueDp2px(12))
        btn.setElevation(0)
        
        btn.onClick = function()
            blueSwitchCharacter(option.index)
            chatContainer.removeAllViews()
            local chatHistory = blueLoadChatHistory()
            if #chatHistory == 0 then
                blueAddMessage("通讯已连接，请报告情况。", false, true)
                blueSaveChatMessage(false, "通讯已连接，请报告情况。")
            else
                for _, msg in ipairs(chatHistory) do
                    blueAddMessage(msg.content, msg.isUser, true)
                end
            end
            dialog.getParent().removeView(dialog)
        end
        
        dialog.addView(btn)
    end
    
    return dialog
end

-- 显示开场故事
local function blueShowOpeningStory(callback)
    local storyLayout = RelativeLayout(activity)
    storyLayout.setLayoutParams(RelativeLayout.LayoutParams(
        RelativeLayout.LayoutParams.MATCH_PARENT,
        RelativeLayout.LayoutParams.MATCH_PARENT
    ))
    storyLayout.setBackgroundColor(Color.BLACK)
   
    local bgImage = ImageView(activity)
    bgImage.setLayoutParams(RelativeLayout.LayoutParams(
        RelativeLayout.LayoutParams.MATCH_PARENT,
        RelativeLayout.LayoutParams.MATCH_PARENT
    ))
    bgImage.setScaleType(ImageView.ScaleType.CENTER_CROP)
    bgImage.setImageResource(activity.getResources().getIdentifier("ic_launcher", "drawable", activity.getPackageName()))
    bgImage.setAlpha(0.2)
    storyLayout.addView(bgImage)
    
    local gradient = GradientDrawable(
        GradientDrawable.Orientation.TOP_BOTTOM,
        {Color.argb(180, 0, 0, 0), Color.argb(220, 0, 0, 0)}
    )
    local gradientView = View(activity)
    gradientView.setLayoutParams(RelativeLayout.LayoutParams(
        RelativeLayout.LayoutParams.MATCH_PARENT,
        RelativeLayout.LayoutParams.MATCH_PARENT
    ))
    gradientView.setBackground(gradient)
    storyLayout.addView(gradientView)
    
    local contentLayout = LinearLayout(activity)
    contentLayout.setLayoutParams(RelativeLayout.LayoutParams(
        RelativeLayout.LayoutParams.MATCH_PARENT,
        RelativeLayout.LayoutParams.MATCH_PARENT
    ))
    contentLayout.setOrientation(1)
    contentLayout.setGravity(Gravity.CENTER)
    contentLayout.setPadding(blueDp2px(24), blueDp2px(48), blueDp2px(24), blueDp2px(48))
    storyLayout.addView(contentLayout)
    
    local skipBtn = MaterialButton(activity)
    local skipParams = RelativeLayout.LayoutParams(
        RelativeLayout.LayoutParams.WRAP_CONTENT,
        RelativeLayout.LayoutParams.WRAP_CONTENT
    )
    skipParams.addRule(RelativeLayout.ALIGN_PARENT_TOP)
    skipParams.addRule(RelativeLayout.ALIGN_PARENT_RIGHT)
    skipParams.topMargin = blueDp2px(16)
    skipParams.rightMargin = blueDp2px(16)
    skipBtn.setLayoutParams(skipParams)
    skipBtn.setText("跳过")
    skipBtn.setTextColor(Color.WHITE)
    skipBtn.setBackgroundColor(Color.TRANSPARENT)
    skipBtn.setRippleColor(ColorStateList.valueOf(Color.WHITE))
    skipBtn.setCornerRadius(blueDp2px(16))
    skipBtn.setPadding(blueDp2px(16), blueDp2px(8), blueDp2px(16), blueDp2px(8))
    skipBtn.setElevation(0)
    skipBtn.setTranslationZ(blueDp2px(4))
    skipBtn.onClick = function()
        blueHandler.removeCallbacksAndMessages(nil)
        storyLayout.getParent().removeView(storyLayout)
        if callback then callback() end
    end
    storyLayout.addView(skipBtn)
    
    local title = TextView(activity)
    title.setLayoutParams(LinearLayout.LayoutParams(
        LinearLayout.LayoutParams.MATCH_PARENT,
        LinearLayout.LayoutParams.WRAP_CONTENT
    ))
    title.setText("背景介绍")
    title.setTextSize(28)
    title.setTextColor(Color.WHITE)
    title.setTypeface(Typeface.create("sans-serif-medium", Typeface.BOLD))
    title.setGravity(Gravity.CENTER)
    title.setPadding(0, 0, 0, blueDp2px(24))
    contentLayout.addView(title)
    
    local storyText = TextView(activity)
    storyText.setLayoutParams(LinearLayout.LayoutParams(
        LinearLayout.LayoutParams.MATCH_PARENT,
        LinearLayout.LayoutParams.WRAP_CONTENT,
        1
    ))
    storyText.setTextSize(20)
    storyText.setTextColor(Color.WHITE)
    storyText.setLineSpacing(blueDp2px(8), 1.3)
    storyText.setGravity(Gravity.CENTER)
    contentLayout.addView(storyText)
    
    local continueBtn = MaterialButton(activity)
    continueBtn.setLayoutParams(LinearLayout.LayoutParams(
        RelativeLayout.LayoutParams.WRAP_CONTENT,
        RelativeLayout.LayoutParams.WRAP_CONTENT
    ))
    continueBtn.setText("进入")
    continueBtn.setTextColor(blueColorScheme.onPrimary)
    continueBtn.setBackgroundColor(blueColorScheme.primary)
    continueBtn.setCornerRadius(blueDp2px(24))
    continueBtn.setPadding(blueDp2px(32), blueDp2px(16), blueDp2px(32), blueDp2px(16))
    continueBtn.setElevation(blueDp2px(4))
    continueBtn.setAlpha(0)
    continueBtn.setTranslationY(blueDp2px(20))
    continueBtn.onClick = function()
        storyLayout.getParent().removeView(storyLayout)
        if callback then callback() end
    end
    contentLayout.addView(continueBtn)
    
    activity.setContentView(storyLayout)
    
    local storyParts = {
        "云智Gemini提供支持\nblue Aurora | AI",
        "本故事为虚构，人物 剧情 事件 皆为虚构，不得以任何形式引用或解读为真实事件。",
        "2724年，代号'X-9'的病毒从北极研究站泄露\n短短72小时内席卷全球主要城市",
        "感染者表现出极端攻击性\n皮肤溃烂、瞳孔变白、失去语言能力\n被感染者称为'白瞳者'",
        "政府紧急启动'方舟计划'\n但只有少数权贵获得避难所资格\n普通人被遗弃在末日废土",
        "90%的人类在第一波感染中变异\n剩下的人要么躲藏，要么组成掠夺者团伙\n文明秩序彻底崩溃",
        "你，陈默，前医学院学生\n在病毒爆发时正在郊区医院实习\n亲眼目睹了人性最黑暗的一面",
        "三个月的地下室生活后\n你决定冒险寻找其他幸存者\n带着仅剩的医疗用品和一本解剖学笔记",
        "在废弃的军事检查站\n你遇到了"..blueCharacterData.name.."\n"..(blueCurrentCharacterIndex==1 and "他正被一群白瞳者围攻" or blueCurrentCharacterIndex==2 and "他正在收集感染者样本" or "他的车队被掠夺者伏击"),
        "你们共同经历了：\n• 血月之夜的尸潮突围\n• 掠夺者的背叛陷阱\n• 稀缺资源的生死争夺",
        "在一次次生死考验中\n你们建立起脆弱的信任关系\n组成了一支求生小队",
        "现在，通讯设备突然接收到信号\n这可能是希望，也可能是新的危机...",
        "活下去！"
    }
    
    local currentPart = 1
    local isSkipped = false
    
    local function showNextPart()
        if isSkipped or currentPart > #storyParts then
            continueBtn.animate()
                .alpha(1)
                .translationY(0)
                .setDuration(500)
                .setInterpolator(DecelerateInterpolator())
                .start()
            return
        end
        
        storyText.setText("")
        blueTypewriterEffect(storyText, storyParts[currentPart], function()
            currentPart = currentPart + 1
            if not isSkipped then
                blueHandler.postDelayed(showNextPart, 2000)
            end
        end)
    end
    
    blueHandler.postDelayed(showNextPart, 500)
end

-- 创建UI界面
local function blueCreateUI()
Ggao()
    local layout = LinearLayout(activity)
    layout.setOrientation(1)
    layout.setBackgroundColor(blueColorScheme.surface)
    layout.setPadding(blueDp2px(16), blueDp2px(16), blueDp2px(16), blueDp2px(16))

    local statusCard = MaterialCardView(activity)
    statusCard.setLayoutParams(LinearLayout.LayoutParams(-1, -2))
    statusCard.setCardBackgroundColor(blueColorScheme.surface)
    statusCard.setCardElevation(blueDp2px(2))
    statusCard.setRadius(blueDp2px(16))
    statusCard.setStrokeColor(blueColorScheme.outline)
    statusCard.setStrokeWidth(blueDp2px(1))
    statusCard.setContentPadding(blueDp2px(16), blueDp2px(16), blueDp2px(16), blueDp2px(16))
    
    local characterDialog = blueCreateCharacterDialog()
    statusCard.setOnClickListener(function()
        local popup = PopupWindow(activity)
        popup.setContentView(characterDialog)
        popup.setWidth(blueDp2px(280))
        popup.setHeight(-2)
        popup.setOutsideTouchable(true)
        popup.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
        popup.setAnimationStyle(android.R.style.Animation_Dialog)
        popup.showAtLocation(layout, Gravity.CENTER, 0, 0)
    end)
    
    local cardContent = LinearLayout(activity)
    cardContent.setOrientation(1)
    
    local infoLayout = LinearLayout(activity)
    infoLayout.setOrientation(1)
    infoLayout.setPadding(0, 0, 0, blueDp2px(8))
    
    nameText = TextView(activity)
    nameText.setText(blueCharacterData.name)
    nameText.setTextColor(blueColorScheme.onSurface)
    nameText.setTextSize(20)
    nameText.setTypeface(Typeface.create("sans-serif-medium", Typeface.BOLD))
    infoLayout.addView(nameText)
    
    descText = TextView(activity)
    descText.setText(blueCharacterData.age .. " | "..(
        blueCurrentCharacterIndex == 1 and "幸存者队长" or 
        blueCurrentCharacterIndex == 2 and "科学家" or 
        "商人首领"
    ))
    descText.setTextColor(blueColorScheme.onSurfaceVariant)
    descText.setTextSize(14)
    descText.setPadding(0, blueDp2px(4), 0, 0)
    infoLayout.addView(descText)
    
    cardContent.addView(infoLayout)
    
    local statsLayout = LinearLayout(activity)
    statsLayout.setOrientation(0)
    statsLayout.setGravity(Gravity.CENTER_VERTICAL)
    statsLayout.setPadding(0, blueDp2px(8), 0, 0)
    
    stat1Text = TextView(activity)
    stat1Text.setLayoutParams(LinearLayout.LayoutParams(0, -2, 1))
    stat1Text.setText(blueCurrentCharacterIndex == 1 and "击杀: "..blueCharacterData.killCount or 
                     blueCurrentCharacterIndex == 2 and "研究: "..blueCharacterData.researchProgress.."%" or
                     "利润: "..blueCharacterData.tradeProfit)
    stat1Text.setTextSize(14)
    stat1Text.setTextColor(blueColorScheme.onSurfaceVariant)
    stat1Text.setGravity(Gravity.START)
    statsLayout.addView(stat1Text)
    
    stat2Text = TextView(activity)
    stat2Text.setLayoutParams(LinearLayout.LayoutParams(0, -2, 1))
    stat2Text.setText(blueCurrentCharacterIndex == 1 and "受伤: "..blueCharacterData.injuryCount or 
                     blueCurrentCharacterIndex == 2 and "风险: "..blueCharacterData.infectionRisk.."%" or
                     "安全: "..blueCharacterData.routeSafety.."%")
    stat2Text.setTextSize(14)
    stat2Text.setTextColor(blueColorScheme.onSurfaceVariant)
    stat2Text.setGravity(Gravity.CENTER)
    statsLayout.addView(stat2Text)
    
    moodText = TextView(activity)
    moodText.setLayoutParams(LinearLayout.LayoutParams(0, -2, 1))
    moodText.setText("情绪: "..blueCharacterData.mood)
    moodText.setTextSize(14)
    moodText.setTextColor(blueMoodColors[blueCharacterData.mood])
    moodText.setGravity(Gravity.END)
    statsLayout.addView(moodText)
    
    cardContent.addView(statsLayout)
    statusCard.addView(cardContent)
    layout.addView(statusCard)

    local scrollView = ScrollView(activity)
    scrollView.setLayoutParams(LinearLayout.LayoutParams(-1, -1, 1))
    scrollView.setPadding(0, blueDp2px(16), 0, 0)

    chatContainer = LinearLayout(activity)
    chatContainer.setOrientation(1)
    chatContainer.setPadding(blueDp2px(4), blueDp2px(4), blueDp2px(4), blueDp2px(4))

    function blueAddMessage(text, isUser, instant, isThinking)
        if isThinking then
            local loadingLayout = LinearLayout(activity)
            loadingLayout.setOrientation(0)
            loadingLayout.setGravity(Gravity.START)
            loadingLayout.setPadding(0, blueDp2px(8), 0, blueDp2px(8))
            loadingLayout.setLayoutParams(LinearLayout.LayoutParams(-1, -2))

            local avatar = ImageView(activity)
            avatar.setImageResource(activity.getResources().getIdentifier("ic_launcher", "drawable", activity.getPackageName()))
            avatar.setScaleType(ImageView.ScaleType.CENTER_CROP)
            
            local shape = MaterialShapeDrawable(
                ShapeAppearanceModel.builder()
                .setAllCorners(CornerFamily.ROUNDED, blueDp2px(20))
                .build())
            shape.setFillColor(ColorStateList.valueOf(blueColorScheme.surfaceVariant))
            avatar.setBackground(shape)
            
            local avatarParams = LinearLayout.LayoutParams(blueDp2px(40), blueDp2px(40))
            avatarParams.setMargins(0, 0, blueDp2px(8), 0)
            loadingLayout.addView(avatar, avatarParams)

            local progress = ProgressBar(activity)
            progress.setIndeterminate(true)
            progress.setIndeterminateTintList(ColorStateList.valueOf(blueColorScheme.primary))
            local progressParams = LinearLayout.LayoutParams(blueDp2px(32), blueDp2px(32))
            progressParams.setMargins(blueDp2px(8), 0, 0, 0)
            loadingLayout.addView(progress, progressParams)

            chatContainer.addView(loadingLayout)
            scrollView.fullScroll(ScrollView.FOCUS_DOWN)
            return loadingLayout
        end

        local messageLayout = LinearLayout(activity)
        messageLayout.setOrientation(0)
        messageLayout.setGravity(isUser and Gravity.END or Gravity.START)
        messageLayout.setPadding(0, blueDp2px(8), 0, blueDp2px(8))
        messageLayout.setLayoutParams(LinearLayout.LayoutParams(-1, -2))

        if not isUser then
            local avatar = ImageView(activity)
            avatar.setImageResource(activity.getResources().getIdentifier("ic_launcher", "drawable", activity.getPackageName()))
            avatar.setScaleType(ImageView.ScaleType.CENTER_CROP)
            
            local shape = MaterialShapeDrawable(
                ShapeAppearanceModel.builder()
                .setAllCorners(CornerFamily.ROUNDED, blueDp2px(20))
                .build())
            shape.setFillColor(ColorStateList.valueOf(blueColorScheme.surfaceVariant))
            avatar.setBackground(shape)
            
            local avatarParams = LinearLayout.LayoutParams(blueDp2px(40), blueDp2px(40))
            avatarParams.setMargins(0, 0, blueDp2px(8), 0)
            messageLayout.addView(avatar, avatarParams)
        end

        local messageText = TextView(activity)
        messageText.setTextSize(16)
        messageText.setTextColor(isUser and blueColorScheme.onPrimary or blueColorScheme.onSurface)
        messageText.setPadding(blueDp2px(16), blueDp2px(12), blueDp2px(16), blueDp2px(12))
        messageText.setLineSpacing(blueDp2px(4), 1.0)

        local bubbleBg = blueCreateBubbleBackground(isUser, isUser and blueColorScheme.primary or blueColorScheme.surfaceVariant)
        messageText.setBackground(bubbleBg)

        if instant then
            messageText.setText(text)
        else
            blueTypewriterEffect(messageText, text, function()
                scrollView.fullScroll(ScrollView.FOCUS_DOWN)
            end)
        end

        messageLayout.addView(messageText)
        
        if isUser then
            local params = messageLayout.getLayoutParams()
            params.leftMargin = blueDp2px(40)
            messageLayout.setLayoutParams(params)
        end
        
        chatContainer.addView(messageLayout)
        scrollView.fullScroll(ScrollView.FOCUS_DOWN)
    end

    local chatHistory = blueLoadChatHistory()
    if #chatHistory == 0 then
        blueAddMessage("通讯已连接，请报告情况。", false, true)
        blueSaveChatMessage(false, "通讯已连接，请报告情况。")
    else
        for _, msg in ipairs(chatHistory) do
            blueAddMessage(msg.content, msg.isUser, true)
        end
    end

    scrollView.addView(chatContainer)
    layout.addView(scrollView)

    local inputContainer = LinearLayout(activity)
    inputContainer.setOrientation(0)
    inputContainer.setGravity(Gravity.CENTER_VERTICAL)
    inputContainer.setPadding(0, blueDp2px(16), 0, 0)
    inputContainer.setLayoutParams(LinearLayout.LayoutParams(-1, -2))

    local inputLayout = TextInputLayout(activity)
    inputLayout.setLayoutParams(LinearLayout.LayoutParams(-1, -2, 1))
    inputLayout.setHint("对"..blueCharacterData.name.."说些什么...")
    inputLayout.setBoxBackgroundMode(TextInputLayout.BOX_BACKGROUND_OUTLINE)
    inputLayout.setBoxCornerRadii(blueDp2px(12), blueDp2px(12), blueDp2px(12), blueDp2px(12))
    inputLayout.setBoxStrokeColorStateList(ColorStateList.valueOf(blueColorScheme.outline))
    inputLayout.setHintTextColor(ColorStateList.valueOf(blueColorScheme.onSurfaceVariant))
    inputLayout.setPrefixText(blueCharacterData.name..": ")
    inputLayout.setPrefixTextColor(ColorStateList.valueOf(blueColorScheme.primary))

    local inputBox = TextInputEditText(activity)
    inputBox.setLayoutParams(LinearLayout.LayoutParams(-1, -2))
    inputBox.setTextSize(16)
    inputBox.setTextColor(blueColorScheme.onSurface)
    inputBox.setBackgroundColor(Color.TRANSPARENT)
    inputBox.setSingleLine(true)
    inputBox.setMaxLines(3)
    inputBox.setImeOptions(EditorInfo.IME_ACTION_SEND)
    inputLayout.addView(inputBox)

    local sendBtn = MaterialButton(activity)
    sendBtn.setLayoutParams(LinearLayout.LayoutParams(-2, -2))
    sendBtn.setText("发送")
    sendBtn.setTextColor(blueColorScheme.onPrimary)
    sendBtn.setBackgroundColor(blueColorScheme.primary)
    sendBtn.setCornerRadius(blueDp2px(12))
    sendBtn.setIconResource(android.R.drawable.ic_menu_send)
    sendBtn.setIconTint(ColorStateList.valueOf(blueColorScheme.onPrimary))
    sendBtn.setIconPadding(blueDp2px(4))
    sendBtn.setMinimumWidth(blueDp2px(64))
    sendBtn.setPadding(blueDp2px(12), blueDp2px(8), blueDp2px(12), blueDp2px(8))
    sendBtn.setElevation(blueDp2px(1))

    sendBtn.onClick = function()
        local msg = inputBox.getText().toString()
        if not TextUtils.isEmpty(msg) then
            blueAddMessage(msg, true, true)
            blueSaveChatMessage(true, msg)
            inputBox.setText("")
            
            local loadingView = blueAddMessage(nil, false, true, true)
            
            blueAI(msg, function(isThinking, response)
                if not isThinking then
                    chatContainer.removeView(loadingView)
                    blueAddMessage(response, false, false)
                    
                    if blueCurrentCharacterIndex == 1 then
                        stat1Text.setText("击杀: "..blueCharacterData.killCount)
                        stat2Text.setText("受伤: "..blueCharacterData.injuryCount)
                    elseif blueCurrentCharacterIndex == 2 then
                        stat1Text.setText("研究: "..blueCharacterData.researchProgress.."%")
                        stat2Text.setText("风险: "..blueCharacterData.infectionRisk.."%")
                    else
                        stat1Text.setText("利润: "..blueCharacterData.tradeProfit)
                        stat2Text.setText("安全: "..blueCharacterData.routeSafety.."%")
                    end
                    
                    moodText.setText("情绪: "..blueCharacterData.mood)
                    moodText.setTextColor(blueMoodColors[blueCharacterData.mood])
                end
            end)
        end
    end

    inputContainer.addView(inputLayout)
    inputContainer.addView(sendBtn)
    layout.addView(inputContainer)

    inputBox.setOnEditorActionListener{
        onEditorAction=function(v, actionId, event)
            if actionId == EditorInfo.IME_ACTION_SEND then
                sendBtn.performClick()
                return true
            end
            return false
        end
    }

    statusCard.setOnLongClickListener{
        onLongClick=function()
            blueClearCurrentChatHistory()
            chatContainer.removeAllViews()
            blueAddMessage("通讯日志已重置，请重新报告。", false, true)
            blueSaveChatMessage(false, "通讯日志已重置，请重新报告。")
            return true
        end
    }

    return layout
end

-- 启动应用
blueShowOpeningStory(function()
    activity.setContentView(blueCreateUI())
    activity.getWindow().setStatusBarColor(blueColorScheme.primary)
    activity.getWindow().setNavigationBarColor(blueColorScheme.surface)
    activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE)
end)

