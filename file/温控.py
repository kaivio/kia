max_temp = 40   # 大于指定温度后开始散热
min_temp = 25   # 达到指定温度后停止散热
delay = 1  # 检测温度频率(秒)

k = 14 # IO口的BCM编号
import time
import RPi.GPIO as GPIO


max_temp *= 1000
min_temp *= 1000


def main():
  lt = 0 
  c = 0   # 连续温度相同次数
  stop_cool()
  while True:
    t = temp()
    log("当前温度："+str(t))
    if t > max_temp:
      cool()
    
    if t < min_temp:
      stop_cool()
    else: # 降温极限检测
      if t // 1000 == lt // 1000:
        c += 1
      else:
        c = 0
      
      if c > 8:
        stop_cool()
        c = 0
        log("温度已到达极限！")
      else:
        lt = t
        
      
    time.sleep(delay)
  # end loop 
# end main


def temp():
  f = open("/sys/class/thermal/thermal_zone0/temp")
  t = int(f.read())
  f.close()
  return t
  
GPIO.setmode(GPIO.BCM)
GPIO.setup(k,GPIO.OUT)

def cool():
  log("cooling")
  GPIO.output(k,GPIO.LOW)

def stop_cool():
  log("stop")
  GPIO.output(k,GPIO.HIGH)


def test():
  stop_cool()
  while True:
    print("当前温度："+str(temp()))
    if input() == "1":
      cool()
    else:
      stop_cool()

def log(msg):
  print(msg)


#test()
main()


