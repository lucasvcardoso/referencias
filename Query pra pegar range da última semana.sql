SELECT 
      LastWeekSunday   = DATEADD(dd, -1, DATEADD(ww, DATEDIFF(ww, 0, GETDATE()) - 1, 0))
      --Logica:
      --LastWeekSunday   = "Tira um dia pra pegar o domingo":DATEADD(dd, -1, {"transformaIntSemanasEmData":DATEADD(ww, ["numeroSemanasDesde1900 - 1":DATEDIFF(ww, 0, GETDATE()) - 1], 0)})
     , LastWeekSaturday = DATEADD(dd,  5, DATEADD(ww, DATEDIFF(ww, 0, GETDATE()) - 1, 0))
      --Logica:
      --LastWeekSunday   = "Soma cinco dias para pegar o sábado":DATEADD(dd, -1, {"transformaIntSemanasEmData":DATEADD(ww, ["numeroSemanasDesde1900 - 1":DATEDIFF(ww, 0, GETDATE()) - 1], 0)})
