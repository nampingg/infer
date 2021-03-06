(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open! IStd
module BasicCostWithReason = CostDomain.BasicCostWithReason

module ProcName = struct
  let dispatch : (Tenv.t, BasicCostWithReason.t, unit) ProcnameDispatcher.ProcName.dispatcher =
    let open ProcnameDispatcher.ProcName in
    let match_builtin builtin _ s = String.equal s (Procname.get_method builtin) in
    make_dispatcher
      [ +match_builtin BuiltinDecl.__new <>--> BasicCostWithReason.one ()
      ; +match_builtin BuiltinDecl.__new_array <>--> BasicCostWithReason.one ()
      ; +match_builtin BuiltinDecl.__objc_alloc_no_fail <>--> BasicCostWithReason.one ()
      ; +match_builtin BuiltinDecl.malloc <>--> BasicCostWithReason.one ()
      ; +match_builtin BuiltinDecl.malloc_no_fail <>--> BasicCostWithReason.one () ]
end
