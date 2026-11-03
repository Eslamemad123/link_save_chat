# Project Rules & Architecture Specification
# تطبيق إدارة ومزامنة الروابط والتاسكات (LinkSync)

هذا الملف يحدد القواعد الصارمة، المعمارية البرمجية، مواصفات الواجهات (UI/UX)، هيكل البيانات، وخطة التنفيذ لجميع مراحل تطوير المشروع.

---

## 1. فكرة المشروع والنطاق (Core Concept & Scope)
- **الهدف:** تطبيق إنتاجية ومزامنة مستوحى من تجربة **WhatsApp** لمزامنة الروابط والتاسكات بين الهاتف واللابتوب بشكل لحظي وبالمجان 100%.
- **المنصات المدعومة:** Mobile (Android & iOS) و Desktop (Windows, macOS, Web).
- **مفهوم الدردشة:** ينشئ المستخدم غرف دردشة مخصصة لتصنيف المحتوى (مثل: *شات لفيديوهات البرمجة، شات لروابط المقالات، شات لمهام العمل*). كل رسالة داخل الشات تمثل رابطاً ذكياً أو مهمة قابلة للإنجاز.

---

## 2. نظام الألوان وحالات المهام (Task & Link Status Hierarchy)
تلتزم جميع فقاعات الشات (Message Bubbles) بالتسلسل اللوني الإلزامي التالي:
1. **أخضر (Green / Completed):** المهمة تم إنجازها (يظهر النص مشطوباً Strikethrough مع علامة صح).
2. **أصفر/عنبري (Yellow/Amber / Important):** له الأولوية القصوى؛ **يبقى أصفر دائماً حتى لو مر عليه أكثر من 3 أيام** ولا يتحول للأحمر أبداً طالما تم تمييزه كمهم.
3. **أحمر (Red / Overdue):** غير مهم ومر عليه 3 أيام دون إنجاز، أو تجاوز تاريخ الديدلاين المحدد.
4. **أزرق (Blue / Normal):** مهمة أو رابط عادي جديد لم يتجاوز 3 أيام.

---

## 3. سلوك التفاعل والواجهات (UI & UX Interactions)
- **النقر العادي (Tap):**
  - على الرابط/الفيديو: يفتح الرابط مباشرة في المتصفح الخارجي أو تطبيق يوتيوب.
  - على التاسك العادية: يفتح شاشة "تفاصيل التاسك".
- **الضغط المطول (Long Press):**
  - يُفعّل وضع التحديد المتعدد (Selection Mode مثل واتساب) مع اهتزاز خفيف (Haptic Feedback).
  - يتحول الشريط العلوي لـ Contextual Action Bar يحتوي على:
    - زر إلغاء التحديد (✖️) + عداد العناصر المحددة.
    - زر ✅ (تغيير الحالة إلى "تم").
    - زر ⭐ (تغيير الحالة إلى "مهم").
    - زر ✏️ (تعديل تفاصيل المهمة).
    - زر 📁 (نقل المهمة لشات آخر).
    - زر 🗑️ (حذف المهمة).
- **المشاركة من التطبيقات الأخرى (System Share Intent):**
  - استقبال الروابط والنصوص عند الضغط على "مشاركة" من يوتيوب أو المتصفح.
  - إظهار نافذة سريعة (Bottom Sheet) للبحث واختيار الشات وحفظ الرابط بضغطة زر واحدة.
- **واجهة الديسكتوب (Desktop Split-View):**
  - تخطيط بعمودين (Two-column layout):
    - العمود الأيسر (35%): قائمة الشاتات، البحث، وفلاتر التصفية (*الكل، متأخرة، مهمة*).
    - العمود الأيمن (65%): المحادثة النشطة وفقاعات الروابط وشريط الإرسال.
  - شاشة "تفاصيل التاسك" تفتح في لوحة جانبية منزلقة (Side Drawer) أو نافذة منبثقة (Modal Dialog).

---

## 4. تقنية ربط الأجهزة والمزامنة (Device Pairing & Auth)
- **ربط الديسكتوب عبر الهاتف (WhatsApp Web Style):**
  - مجاني 100% ويعتمد بالكامل على Firestore وحزمتي `qr_flutter` و `mobile_scanner`.
  - الديسكتوب يولد معرف جلسة عشوائي (`uuid`) وينشئ مستنداً مؤقتاً في Firestore ويعرضه كـ QR Code مع كود PIN بديل من 6 أرقام.
  - تطبيق الموبايل يمسح الرمز بكاميرته (أو يدخل كود الـ PIN يدوياً) ويكتب معرف المستخدم (UID/Token) في نفس المستند.
  - الديسكتوب يستمع لحظياً لتحديث المستند ويسجل دخوله فورياً بدون أي طرف ثالث.
- **تسجيل الدخول البديل:** تسجيل الدخول عبر Google Sign-In والبريد الإلكتروني على الهاتف واللابتوب.

---

## 5. الحزم والاعتماديات المعتمدة (Dependencies Stack)
- **State Management:** `flutter_bloc`, `get_it`, `equatable`.
- **Firebase & Cloud:** `firebase_core`, `cloud_firestore`, `firebase_auth`, `google_sign_in`, `cloudinary_public`.
- **Local Cache & Storage:** `shared_preferences`, `hive`, `hive_flutter`.
- **Device Pairing & QR:** `qr_flutter`, `mobile_scanner`, `uuid`.
- **Share Intent:** `receive_sharing_intent`.
- **Link Scraping & Launch:** `metadata_fetch` أو `any_link_preview`, `url_launcher`.
- **Notifications:** `flutter_local_notifications`.
- **UI & Media:** `cached_network_image`, `image_picker`, `file_picker`, `intl`.

---

## 6. القواعد الهندسية لتسلسل التنفيذ (Development Principles)
1. **الدارك مود واللغة (من البداية تماماً):**
   - تأسيس `ThemeData` (الوضع الفاتح والداكن) ونظام الخطوط والاتجاه العربي RTL في `core/theme/` من **اليوم الثاني**، لتفادي تعديل مئات الألوان لاحقاً.
   - قراءة كافة الألوان من `Theme.of(context)` بدلاً من كتابة ألوان ثابتة (No hardcoded colors).
2. **الفايربيز أولاً (Firebase First):**
   - ربط وإعداد Firebase في اليوم الثاني؛ لأن المصادقة والشاتات والمزامنة تعتمد عليه كلياً.
3. **منهجية ميزة بميزة متكاملة (Feature by Feature):**
   - لكل ميزة يتم بناء الواجهات (`ui/`) ثم المنطق (`logic/`) والربط مع Firebase واختبارها فعلياً والتأكد من نجاحها قبل الانتقال للميزة التالية.
4. **التسلسل المنطقي للبناء:**
   - الأساسيات (Core) ⬅️ البوابة (Auth) ⬅️ القلب (Home & Chat) ⬅️ التفاصيل والربط (Tasks & QR) ⬅️ الإعدادات والديسكتوب.

---

## 7. هيكلية المجلدات التسعة المعتمدة وتوزيع الشاشات (Feature-First Architecture)

يُمنع منعاً باتاً إنشاء مجلد Feature جديد لكل نافذة فرعية، بل توضع الشاشات الفرعية داخل ميزتها الأم كالتالي:

```text
lib/
  ├── core/                     (Theme, Routing, DI, Services, Widgets العامة)
  │
  └── features/
        ├── splash/             (شاشة البداية وفحص حالة المستخدم)
        ├── onboarding/         (شرائح الترحيب الثلاث)
        │
        ├── auth/               (تجمع شاشات المصادقة)
        │     ├── login_view.dart
        │     ├── register_view.dart
        │     └── reset_password_view.dart
        │
        ├── device_pairing/     (تجمع شاشات ربط اللابتوب)
        │     ├── qr_scanner_view.dart (مسح الكود بالموبايل)
        │     ├── manual_pin_entry_view.dart (إدخال الكود يدوياً)
        │     └── linked_devices_view.dart (إدارة الأجهزة المتصلة)
        │
        ├── home/               (الشاشة الرئيسية للدردشات)
        │     ├── home_view.dart (قائمة الشاتات والفلاتر)
        │     ├── create_new_chat_dialog.dart (نافذة إنشاء شات جديد)
        │     └── global_search_view.dart (البحث العام في كل الروابط)
        │
        ├── chat/               (محتوى المحادثة الواحدة)
        │     ├── chat_view.dart (الفقاعات الملونة والروابط الذكية)
        │     ├── chat_info_view.dart (إحصائيات ومعلومات الشات)
        │     └── edit_chat_view.dart (تعديل اسم وصورة الشات)
        │
        ├── task_details/       (تفاصيل وتعديل المهمة)
        │     └── task_details_view.dart (المهام الفرعية والديدلاين والأولوية)
        │
        ├── share_intent/       (المشاركة من التطبيقات الأخرى)
        │     └── share_intent_bottom_sheet.dart (حفظ الرابط من يوتيوب/كروم)
        │
        └── settings/           (الإعدادات والتخصيص)
              ├── settings_view.dart (الإعدادات العامة والمظهر)
              ├── edit_profile_view.dart (تعديل بيانات وصورة المستخدم)
              ├── add_custom_list_view.dart (إنشاء وإدارة القوائم والتصنيفات)
              └── wallpaper_picker_bottom_sheet.dart (اختيار وتخصيص الخلفيات)
```

---

## 8. نموذج البيانات في Firestore (Database Schema)
```text
users/{userId}
  ├── email: string
  ├── displayName: string
  ├── username: string
  ├── bio: string
  ├── avatarUrl: string
  ├── settings: {
  │     themeMode: "light" | "dark" | "system",
  │     primaryColor: int,
  │     defaultWallpaper: string,
  │     language: "ar" | "en"
  │   }
  │
  ├── custom_lists/{listId}
  │     ├── name: string
  │     ├── icon: string
  │     ├── colorCode: int
  │     └── includedChatIds: [ string ]
  │
  ├── chats/{chatId}
  │     ├── title: string
  │     ├── iconUrl: string
  │     ├── customWallpaper: string
  │     ├── uncompletedCount: int
  │     ├── isPinned: bool
  │     ├── updatedAt: timestamp
  │     │
  │     └── items/{itemId}
  │           ├── type: "link" | "task"
  │           ├── content: string
  │           ├── url: string (nullable)
  │           ├── metadata: { title, image, domain }
  │           ├── status: "normal" | "important" | "overdue" | "completed"
  │           ├── deadline: timestamp (nullable)
  │           ├── createdAt: timestamp
  │           ├── isPinned: bool
  │           └── subtasks: [ { id, title, isDone } ]

pairing_sessions/{sessionId}
  ├── pinCode: string (6-digit)
  ├── status: "pending" | "authenticated" | "expired"
  ├── authToken: string (nullable)
  └── createdAt: timestamp
```

---

## 9. قواعد الكود وهندسة الويدجت في Flutter (Code & Architecture Rules)
1. **ممنوع نهائياً إنشاء دوال أو ميثودز تُرجع ويدجت** مثل `_buildItem()` أو `_buildHeader()`.
2. **كل ويدجت مستقل يجب أن يكون في ملف منفصل** داخل مجلد `widgets/` الخاص بالـ Feature.
3. **استخدام ويدجت رئيسية لكل شاشة** باسم `<Feature>ViewBody` في ملف منفصل لتجميع العناصر والـ Layout.
4. **جميع الكونسركتورز** يجب أن تتضمن `{super.key}` واستخدام `const` أينما أمكن.
5. **ممنوع وضع التعليقات البرمجية (Comments)** إطلاقاً إلا إذا طلب المستخدم ذلك صراحة.
6. **التجاوب وأبعاد الشاشات (Screen Responsiveness عبر flutter_screenutil):**
   - استخدام ملحقات `flutter_screenutil` إجبارياً مع كل رقم يضاف في الـ UI (`.h` للارتفاعات، `.w` للعروض، `.r` للأنصاف أقطار والحواف الدائرية، `.sp` لأحجام الخطوط، إلخ) لمراعاة اختلاف أبعاد الشاشات.
7. **إدارة الثيم والألوان (Dark & Light Theme):**
   - التطبيق يدعم الوضعين الداكن والفاتح (Dark Mode و Light Mode).
   - عند إنشاء أو إضافة ألوان جديدة، يجب دائماً حساب ومعالجة اللون في كلا الوضعين (Dark & Light).
   - توضع وتُدار جميع تعديلات وتكوينات الثيم داخل ملف `lib/core/utils/theme.dart`.
   - قراءة كافة الألوان من `Theme.of(context)` بدلاً من كتابة ألوان ثابتة لتسهيل التبديل التلقائي.
8. **مركزية الألوان الإلزامية (Centralized Colors via `AppColors`):**
   - ممنوع نهائياً كتابة أي لون ثابت (Hardcoded) مثل `Color(0x...)` أو استخدام `Colors.<name>` بشكل مباشر داخل أي ملف في المشروع.
   - جميع الألوان يجب أن تُستدعى حصرياً من `AppColors` الموجود في `lib/core/utils/colors.dart`.
   - إذا ظهرت حاجة لأي لون غير موجود في الكلاس، يجب أولاً إضافته إلى `AppColors` باسم وصفي ودلالي (Semantic Name)، ثم استدعاؤه منه.

---

## 10. الخطة الزمنية للتنفيذ (Roadmap Timeline)
- **تاريخ البداية:** الثلاثاء 3 نوفمبر 2026.
- **تاريخ الانتهاء والتسليم:** الأربعاء 2 ديسمبر 2026.
- **معدل العمل اليومي:** 2.5 إلى 3 ساعات يومياً (6 أيام أسبوعياً مع راحة يوم الجمعة).
- **التفاصيل اليومية:** موثقة خطوة بخطوة في ملف PDF المعتمد: `LinkSync_Project_Plan.pdf`.

