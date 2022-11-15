
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/model/InitcallModel.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:rxdart/subjects.dart';
// import 'package:package_info_plus/package_info_plus.dart';

const social_ic_user1 = "images/user.png";
const maps = "images/maps.png";
const whatsapp_icon = "images/whatsapp.png";
const whatsappunselected_icon = "images/whatsapp_unselected.png";
const facebooktab_icon = "images/facebook.png";

const messangerfb_icon = "images/messangerfb.png";

const facebook_icon = "images/facebook_icon.png";
const telegram_icon = "images/telegram.png";
const telegramunselected_icon = "images/telegram_unselected.png";
const open_icon = "images/open.png";
const openactive_icon = "images/open_active.png";
const progress_icon = "images/progress.png";
const logo = "images/logo.png";
const logo_round = "images/logo_round.png";
const progressactive_icon = "images/progress_active.png";
const chatdash = "images/chatdash.png";
const customerdash = "images/customerdash.png";
const teamdash = "images/teamdash.png";
const close_icon = "images/closed.png";
const openempty_icon = "images/open_empty.png";
const support_empty = "images/support_empty.png";
const call_empty = "images/call_empty.png";
const whatsapp_white = "images/whatsapp_white.png";
const whatsapp_lightwhite = "images/whatsapp_lightwhite.png";
const telegram_lightwhite = "images/telegram_lightwhite.png";
const telegram_white = "images/telegram_white.png";

const progressempty_icon = "images/progress_empty.png";

const invited_users = "images/invited_users.png";
const not_invited_users = "images/not_invited_users.png";

const closeempty_icon = "images/close_empty.png";
const closeactive_icon = "images/close_active.png";
const incoming = "images/incoming.png";
const loader = "images/loader.gif";
const pin = "images/push_pin.png";
const converge_icon = "images/converge.png";
const converge_light = "images/converge_light.png";
const pdficon = "images/pdf_white.png";
const intro_2 = "images/2intro.png";
const intro_3 = "images/3intro.png";
const intro_1 = "images/1intro.png";
const logo_converges = "images/logo_converge.png";

const linkedin_icon = "images/linkedin.png";
const twitter_icon = "images/twitter.png";
const google_icon = "images/google_icon.png";
const google_icon_con = "images/google_icon_con.png";
const dashboradmsg = "images/dashboard_msg.png";
const supportscreen = "images/support_screens.png";
const privacypolicy = "https://web.feetport.com/legal/privacy-policy/";
const termslink = "https://web.feetport.com/legal/terms-and-conditions";
const linkedin_link = "https://www.linkedin.com/company/feetport";
const twitter_link = "https://twitter.com/feetport";
const groovelogo = "images/groove_logo.png";
String mode = 'private';
String? authtoken;


String? SelectedThreadID="";
Socket? socket;

String AuthorizationToken =
    "Token SRUogoa8uDFEvoashWVYhjYT7CLodmHX:I9ZnyhuNIMMcB7XZuGqN94xjcgeSuU9e";


String GoogleConvergeLink="https://business-messages-launcher.appspot.com/?url=https%3A%2F%2Fbusiness.google.com%2FinitiateBusinessChat%3Fargs%3DCigIAxIkYjUyNTZkOTQtZjk3MC00ZTk5LWJkZGYtNzFmYjQ2NzU1ZGJlYgd3ZWJ2aWV3aiJodHRwOi8vYnVzaW5lc3NtZXNzYWdlcy5nb29nbGUuY29tckIIAxIkYjUyNTZkOTQtZjk3MC00ZTk5LWJkZGYtNzFmYjQ2NzU1ZGJlGgpjYy1saXN0aW5nIgw5Njg2MTA1NTQ1NDCaAa0BChJjYy1saXN0aW5nX2NvbnRleHQSlgEKOHR5cGUuZ29vZ2xlYXBpcy5jb20vY2hhdC5ib3QucGxhdGZvcm0uQnVzaW5lc3NIdWJDb250ZXh0EloyHQobQ2hJSm4zd0FMN3Z2RHprUk5MVldiRzhRM19zSAhaJgoYb3ZlcnJpZGVfY3JtX2VudHJ5X3BvaW50EgpQTEFDRVNIRUVUWg8KB2lzX3Rlc3QSBHRydWU%26hl%3Den";
String api_version = '0.0.1';
String? base_domain="";

String CommanURl="/api/connect/sdk/1.0/";




// String filterToAppLocaleString ="";
bool isnew = true;
int isManager = 0;
String name = 'Ram verma';
bool isInvited = false;
Map updatefield_response = {
  'message': "has been assigned this chat",
  'isUpdated': false
};
String TimePlatform= "";
bool IsOtherThread= false;
// PackageInfo packageInfo;
bool IsShowVoiceCallScreen = false;
String  ChangedThreadId= "";

bool NotShowCategory =false;
Categories? selectedCatogary = null;

dynamic mDataPrivatemessage;
bool IsShowPasscodeScreen = false;

// String mFirstNameKey = "mahal";
// String mLastNameKey = "singh";
// String mUUidKey = "9814406463";
// String x_fp_api_key = "mZPP6Wf7ZswjtCwNaxWhHFZMoqwPMKMX";

String? mFirstNameKey = "";
String? mLastNameKey = "";
String? mUUidKey = "";
String? OrgCode = "";

String? x_fp_api_key = "";
// String mUrl = "";
String? FCM_TOKEN = "";
RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
bool loading = true;

bool CallAfterSomeTime = false;
bool Is_VIEWAS_USER = false;

bool IsSearchEnable = false;
List<String> SearchTagsList = [];

bool IsResultGetAfterSomeTime = false;

bool AssignedToMyTeam = false;
String ViewAsUser_Name = "";
var mSelectedcolor;

bool mShowScubscribeBtn = false;

Map<String, bool> mNotificationValues = {
  "sound": true,
  "apppreview": true,
  "message": true,
  "chatassign": true,
  "new": true,
  "call": true,
  "contact": true,
  "unassigned": true,
  "contactunassign": true,
};

List<String> SubscribeSockets = [];
String mUsername = "";
String   mLanguageCode ="en";
String TempleteDbBox = "templetes";
String ContactfieldsBox="subfd";
String UsersBox="usersbox";

String ChattableBox="chatstablebox";
String FullmsgBox="fullmsgbox";

String ChatmodelBox="chatmodelbox";
String AssigneusersBox="Assigneusersbox";

String GroupsBox="Groupsbox";
String FiltersBox="FiltersBox";
String ChatItemsBox="ChatItemsBox";
String ChatMediaBox="ChatMediaBox";
String RolePermissionBox="RolePermissionBox";
String RolesBox="RolesBox";

String MainScreenBox="addForm";
String FormInterfaceBox="form";

String CannedMsgBox="CannedMsgBox";

String TimeLineBox="TimeLineBox";
String UnAssignedBox="UnAssignedBox";

const int UsersBoxTYPE_ID = 1;
const int TempletesBoxTYPE_ID = 2;
const int ContactsBoxTYPE_ID = 3;
const int ChatsBoxTYPE_ID = 4;
const int FullMsgBoxTYPE_ID = 5;
const int ChatModelBoxTYPE_ID = 6;
const int AssignedUsersBoxTYPE_ID = 7;
const int GroupsBoxTYPE_ID = 8;
const int RolePermission_ID = 9;
const int RolesBoxTYPE_ID = 10;
const int  CollectionMetaChildTYPE_ID = 11;
const int CollectionMetaTYPE_ID = 12;
const int CannedMsg_ID = 13;
const int FiltersMsg_ID = 14;
const int ChatMetaBoxTYPE_ID = 15;
const int ChatMediaBoxTYPE_ID = 16;
const int TimeLineBoxTYPE_ID = 17;
const int UnAssignedBoxTYPE_ID = 18;




String WhatsappPlatform = 'whatsapp';
String CallHistoryPlatform = 'call_history';
String ConvergePlatform = 'Converge';
String TelegramPlatform = 'telegram';
String FacebookPlatform = 'facebook';
String TwitterPlatform = 'twitter';
String GooglePlatform = 'google';

String ConvergePlatformSmall = 'converge';

String sockname="";
String opentb = 'open';
String progresstb = 'progress';
String closetb = 'closed';
// String mUniqueid ="uniques";

String usersnameview = 'Ram verma';
bool IsConnectionAvailable = true;
String Filterfor = '';

String mNotificationChatMessages="Default";
String mNotificationAssignChat="Assign Chat";
String mNotificationUnAssignChat="Unassign Chat";

String CurrentThreadName = '';


String FilterforChats = 'chats';
String FilterforUsers = 'team';
String FilterforContacts = 'contacts';

String  SelectedUsersFilters= "";

LOG(String text) {
  if (!kReleaseMode) {
    if (kIsWeb) {
      print(text);
    } else {
      log(text);
    }
  }
}