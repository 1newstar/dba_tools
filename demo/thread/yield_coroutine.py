#coding:utf8
#协程demo

import time


def consumer():
    c_response = ''
    while True:
        n = yield c_response
        if not n:
            return
        print('[CONSUMER] Consuming %s...' % n)
        c_response=int(n)*int(n)
        time.sleep(1)
        
        
def produce(c):
    c.next()
    n = 0
    while n < 5:
        n = n + 1
        print('[PRODUCER] Producing %s...' % n)
        c_response = c.send(n)
        print('[PRODUCER] Consumer return: %s' % c_response)
    c.close()

    
if __name__=='__main__':
    c = consumer()
    produce(c)
