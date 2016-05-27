let bool_to_string b = match b with
  | true -> "Authorized"
  | false -> "Unauthorized"

let q = Cordova_qr_scanner.t ()

let callback_scan err res = match err with
    | None -> Dom_html.window##(alert (Js.string res))
    | Some x -> Dom_html.window##(alert (Js.string x#name))

let scan_now () =
  q#scan callback_scan

let callback_prepare err status =
  match err with
  | None -> Dom_html.window##(alert (Js.string (bool_to_string
  status#authorized))); scan_now ()
  | Some x -> Dom_html.window##(alert (Js.string x#name))

let on_device_ready () =
  let q = Cordova_qr_scanner.t () in
  q#prepare callback_prepare

let _ = Cordova.Event.device_ready on_device_ready
