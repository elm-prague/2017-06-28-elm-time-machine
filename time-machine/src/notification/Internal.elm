module Internal exposing (..)

import NotificationTypes exposing (..)
import Time exposing (Time)


updateNotifications : Toast a -> List (Notification a) -> Toast a
updateNotifications (Toast toast) list =
    Toast { toast | notifications = list }


config : Toast a -> InternalConfig
config (Toast toast) =
    toast.config


listAllNotifications : Toast a -> List (Notification a)
listAllNotifications (Toast toast) =
    toast.notifications


member : Notification a -> Toast a -> Bool
member notification (Toast internalToast) =
    List.member notification internalToast.notifications


sanityCheck : Notification a -> Bool
sanityCheck (Notification notification) =
    (notification.startTime == 0 && notification.expirationTime == 0) ||
    (notification.startTime < notification.expirationTime)

updatePendingNotifications: Time -> List (Notification a) -> List (Notification a)
updatePendingNotifications time notifications =
    List.map (\notification ->
                  updateNotificationTime time notification
             ) <| notifications

updateNotificationTime: Time -> Notification a -> Notification a
updateNotificationTime time (Notification notification) =
    if notification.startTime == 0 && notification.expirationTime == 0 then
        Notification { notification
        | startTime = time + notification.startDelay
          , expirationTime = time + notification.startDelay + notification.duration
        }
    else
        Notification notification