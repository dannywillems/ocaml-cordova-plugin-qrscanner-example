let bool_to_string b = match b with
  | true -> "Authorized"
  | false -> "Unauthorized"

let scan_now () =
  let q = Qrscanner.qrscanner () in
  q##(scan (fun err res ->
    let err_ocaml = Js.Opt.to_option err in
    match err_ocaml with
    | None -> Dom_html.window##(alert res)
    | Some x -> Dom_html.window##(alert x##.name)))

let on_device_ready _ =
  let q = Qrscanner.qrscanner () in
  q##(prepare (fun err status ->
    let err_ocaml = Js.Opt.to_option err in
    match err_ocaml with
    | None -> Dom_html.window##(alert (Js.string (bool_to_string
    status##.authorized))); scan_now ()
    | Some x -> Dom_html.window##(alert x##.name)));
  Js._false

let _ =
  Dom.addEventListener Dom_html.document (Dom.Event.make "deviceready")
  (Dom_html.handler on_device_ready) Js._false
