module NotificationHelper exposing (..)

import Toast
import Toast exposing (Toast)
import Time exposing (Time)
import Types exposing (NotificationExt, AppNotification)
import Html exposing (Html, li)
import Html.Keyed exposing (ul)
import Html.Attributes exposing (class, classList)

subscriptions : NotificationExt a -> (Time -> msg) -> Sub msg
subscriptions model msg =
    if List.isEmpty <| Toast.listValidNotifications model.toast model.time then
        Sub.none
    else
        Time.every (Time.millisecond * 500) msg

updateNotificationTime : NotificationExt a -> Time -> NotificationExt a
updateNotificationTime model newTime =
    let
        newToast =
            Toast.updateTimestamp newTime model.toast
    in
        { model | toast = newToast, time = newTime }

initToast : Toast AppNotification
initToast =
    (Toast.initWithTransitionDelay <| Time.second * 3)

postNotification : AppNotification -> NotificationExt a -> NotificationExt a
postNotification notification model =
    let
       duration = Time.second * 3
       newToastNotification =
           Toast.createFutureNotificationWithoutDelay notification  duration
       newToast =
           Toast.addNotification newToastNotification model.toast
    in
       { model | toast = newToast }

notificationsView : Toast AppNotification -> Time -> Html msg
notificationsView toast time =
    Html.Keyed.ul [ class "notifications-list" ] (Toast.keyedViews toast time notificationView)


notificationView : Toast.NotificationState -> AppNotification -> Html msg
notificationView state notification =
    Html.li
        [ classList
            [ ( "notification", True )
            , ( "notification--important", notification.important )
            , ( "notification--hidden", (state == Toast.Hiding) )
            ]
        ]
        [ Html.div [ class "notification__content" ] [ Html.text notification.message ] ]