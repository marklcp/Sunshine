if [[ -f /sys/devices/platform/soc/1d84000.ufshc/health_descriptor/life_time_estimation_a ]]; then
  bDeviceLifeTimeEstA=$(cat /sys/devices/platform/soc/1d84000.ufshc/health_descriptor/life_time_estimation_a)
else
  bDeviceLifeTimeEstA=$(cat /sys/kernel/debug/*.ufshc/dump_health_desc 2>/dev/null | grep bDeviceLifeTimeEstA | cut -f2 -d '=' | cut -f2 -d ' ')
fi
# 0x00	未找到有关设备使用寿命的信息。
# 0x01	设备估计使用寿命的 0% 到 10%。
# 0x02	设备估计使用寿命的 10% 到 20%。
# 0x03	设备估计使用寿命的 20% 到 30%。
# 0x04	设备估计使用寿命的 30% 到 40%。
# 0x05	设备估计使用寿命的 40% 到 50%。
# 0x06	设备估计使用寿命的 50% 到 60%。
# 0x07	设备估计使用寿命的 60% 到 70%。
# 0x08	设备估计使用寿命的 70% 到 80%。
# 0x09	设备估计使用寿命的 80% 到 90%。
# 0x0A	设备估计使用寿命的 90% 到 100%。
# 0x0B	设备已超过其估计的使用寿命。

case $bDeviceLifeTimeEstA in
"0x00"|"0x00")
  echo '已使用寿命 未知'
;;
"0x01"|"0x1")
  echo '已使用寿命 0% ~ 10%'
;;
"0x02"|"0x2")
  echo '已使用寿命 10% ~ 20%'
;;
"0x03"|"0x3")
  echo '已使用寿命 20% ~ 30%'
;;
"0x04"|"0x4")
  echo '已使用寿命 30% ~ 40%'
;;
"0x05"|"0x5")
  echo '已使用寿命 40% ~ 50%'
;;
"0x06"|"0x6")
  echo '已使用寿命 50% ~ 60%'
;;
"0x07"|"0x7")
  echo '已使用寿命 60% ~ 70%'
;;
"0x08"|"0x8")
  echo '已使用寿命 70% ~ 80%'
;;
"0x09"|"0x9")
  echo '已使用寿命 80% ~ 90%'
;;
"0x0A"|"0xA")
  echo '已使用寿命 90% ~ 100%'
;;
"0x0B"|"0xB")
  echo '已超过预估寿命'
;;
*)
  echo '已使用寿命 未知'
;;
esac
if [[ -f /sys/devices/platform/soc/1d84000.ufshc/health_descriptor/eol_info ]]; then
  bPreEOLInfo=$(cat /sys/devices/platform/soc/1d84000.ufshc/health_descriptor/eol_info)
else
  bPreEOLInfo=$(cat /sys/kernel/debug/*.ufshc/dump_health_desc | grep bPreEOLInfo | cut -f2 -d '=' | cut -f2 -d ' ')
fi
# 0x00	未定义成员。
# 0x01	正常。消耗不到 80% 的保留区块。
# 0x02	消耗了 80% 的保留区块。
# 0x03	危急。消耗了 90% 的保留区块。
# 所有其他值	保留供将来使用。

case $bPreEOLInfo in
"0x00"|"0x00")
  echo '保留区块磨损 未知'
;;
"0x01"|"0x1")
  echo '保留区块磨损 < 80%'
;;
"0x02"|"0x2")
  echo '保留区块磨损 ≈ 80%'
;;
"0x03"|"0x3")
  echo '保留区块磨损 > 90%'
;;
*)
  echo '保留区块磨损 未知'
;;
esac