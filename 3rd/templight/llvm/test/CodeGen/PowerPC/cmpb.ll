; RUN: llc -mcpu pwr7 < %s | FileCheck %s
target datalayout = "E-m:e-i64:64-n32:64"
target triple = "powerpc64-unknown-linux-gnu"

; Function Attrs: nounwind readnone
define zeroext i16 @test16(i16 zeroext %x, i16 zeroext %y) #0 {
entry:
  %0 = xor i16 %y, %x
  %1 = and i16 %0, 255
  %cmp = icmp eq i16 %1, 0
  %cmp20 = icmp ult i16 %0, 256
  %conv25 = select i1 %cmp, i32 255, i32 0
  %conv27 = select i1 %cmp20, i32 65280, i32 0
  %or = or i32 %conv25, %conv27
  %conv29 = trunc i32 %or to i16
  ret i16 %conv29

; CHECK-LABEL: @test16
; CHECK: cmpb [[REG1:[0-9]+]], 4, 3
; CHECK: clrldi 3, [[REG1]], 48
; CHECK: blr
}

define zeroext i16 @test16p1(i16 zeroext %x, i16 zeroext %y) #0 {
entry:
  %0 = xor i16 %y, %x
  %1 = and i16 %0, 255
  %cmp = icmp eq i16 %1, 0
  %cmp20 = icmp ult i16 %0, 256
  %conv28 = select i1 %cmp, i32 5, i32 0
  %conv30 = select i1 %cmp20, i32 65280, i32 0
  %or = or i32 %conv28, %conv30
  %conv32 = trunc i32 %or to i16
  ret i16 %conv32

; CHECK-LABEL: @test16p1
; CHECK: cmpb [[REG1:[0-9]+]], 4, 3
; CHECK: andi. 3, [[REG1]], 65285
; CHECK: blr
}

; Function Attrs: nounwind readnone
define zeroext i16 @test16p2(i16 zeroext %x, i16 zeroext %y) #0 {
entry:
  %0 = xor i16 %y, %x
  %1 = and i16 %0, 255
  %cmp = icmp eq i16 %1, 0
  %cmp20 = icmp ult i16 %0, 256
  %conv28 = select i1 %cmp, i32 255, i32 0
  %conv30 = select i1 %cmp20, i32 1280, i32 0
  %or = or i32 %conv28, %conv30
  %conv32 = trunc i32 %or to i16
  ret i16 %conv32

; CHECK-LABEL: @test16p2
; CHECK: cmpb [[REG1:[0-9]+]], 4, 3
; CHECK: andi. 3, [[REG1]], 1535
; CHECK: blr
}

; Function Attrs: nounwind readnone
define zeroext i16 @test16p3(i16 zeroext %x, i16 zeroext %y) #0 {
entry:
  %0 = xor i16 %y, %x
  %1 = and i16 %0, 255
  %cmp = icmp eq i16 %1, 0
  %cmp20 = icmp ult i16 %0, 256
  %conv27 = select i1 %cmp, i32 255, i32 0
  %conv29 = select i1 %cmp20, i32 1024, i32 1280
  %or = or i32 %conv27, %conv29
  %conv31 = trunc i32 %or to i16
  ret i16 %conv31

; CHECK-LABEL: @test16p3
; CHECK: cmpb [[REG1:[0-9]+]], 4, 3
; CHECK: clrldi [[REG2:[0-9]+]], [[REG1]], 55
; CHECK: xori 3, [[REG2]], 1280
; CHECK: blr
}

define zeroext i32 @test32(i32 zeroext %x, i32 zeroext %y) #0 {
entry:
  %0 = xor i32 %y, %x
  %1 = and i32 %0, 255
  %cmp = icmp eq i32 %1, 0
  %2 = and i32 %0, 65280
  %cmp28 = icmp eq i32 %2, 0
  %3 = and i32 %0, 16711680
  %cmp34 = icmp eq i32 %3, 0
  %cmp40 = icmp ult i32 %0, 16777216
  %conv44 = select i1 %cmp, i32 255, i32 0
  %conv45 = select i1 %cmp28, i32 65280, i32 0
  %conv47 = select i1 %cmp34, i32 16711680, i32 0
  %conv50 = select i1 %cmp40, i32 -16777216, i32 0
  %or = or i32 %conv45, %conv50
  %or49 = or i32 %or, %conv44
  %or52 = or i32 %or49, %conv47
  ret i32 %or52

; CHECK-LABEL: @test32
; CHECK: cmpb [[REG1:[0-9]+]], 4, 3
; CHECK: clrldi 3, [[REG1]], 32
; CHECK: blr
}

define zeroext i32 @test32p1(i32 zeroext %x, i32 zeroext %y) #0 {
entry:
  %0 = xor i32 %y, %x
  %1 = and i32 %0, 255
  %cmp = icmp eq i32 %1, 0
  %2 = and i32 %0, 65280
  %cmp28 = icmp eq i32 %2, 0
  %3 = and i32 %0, 16711680
  %cmp34 = icmp eq i32 %3, 0
  %cmp40 = icmp ult i32 %0, 16777216
  %conv47 = select i1 %cmp, i32 255, i32 0
  %conv48 = select i1 %cmp28, i32 65280, i32 0
  %conv50 = select i1 %cmp34, i32 458752, i32 0
  %conv53 = select i1 %cmp40, i32 -16777216, i32 0
  %or = or i32 %conv48, %conv53
  %or52 = or i32 %or, %conv47
  %or55 = or i32 %or52, %conv50
  ret i32 %or55

; CHECK-LABEL: @test32p1
; CHECK: li [[REG1:[0-9]+]], 0
; CHECK: cmpb [[REG4:[0-9]+]], 4, 3
; CHECK: oris [[REG2:[0-9]+]], [[REG1]], 65287
; CHECK: ori [[REG3:[0-9]+]], [[REG2]], 65535
; CHECK: and 3, [[REG4]], [[REG3]]
; CHECK: blr
}

define zeroext i32 @test32p2(i32 zeroext %x, i32 zeroext %y) #0 {
entry:
  %0 = xor i32 %y, %x
  %1 = and i32 %0, 255
  %cmp = icmp eq i32 %1, 0
  %2 = and i32 %0, 65280
  %cmp22 = icmp eq i32 %2, 0
  %cmp28 = icmp ult i32 %0, 16777216
  %conv32 = select i1 %cmp, i32 255, i32 0
  %conv33 = select i1 %cmp22, i32 65280, i32 0
  %conv35 = select i1 %cmp28, i32 -16777216, i32 0
  %or = or i32 %conv33, %conv35
  %or37 = or i32 %or, %conv32
  ret i32 %or37

; CHECK-LABEL: @test32p2
; CHECK: li [[REG1:[0-9]+]], 0
; CHECK: cmpb [[REG4:[0-9]+]], 4, 3
; CHECK: oris [[REG2:[0-9]+]], [[REG1]], 65280
; CHECK: ori [[REG3:[0-9]+]], [[REG2]], 65535
; CHECK: and 3, [[REG4]], [[REG3]]
; CHECK: blr
}

define i64 @test64(i64 %x, i64 %y) #0 {
entry:
  %shr19 = lshr i64 %x, 56
  %conv21 = trunc i64 %shr19 to i32
  %shr43 = lshr i64 %y, 56
  %conv45 = trunc i64 %shr43 to i32
  %0 = xor i64 %y, %x
  %1 = and i64 %0, 255
  %cmp = icmp eq i64 %1, 0
  %2 = and i64 %0, 65280
  %cmp52 = icmp eq i64 %2, 0
  %3 = and i64 %0, 16711680
  %cmp58 = icmp eq i64 %3, 0
  %4 = and i64 %0, 4278190080
  %cmp64 = icmp eq i64 %4, 0
  %5 = and i64 %0, 1095216660480
  %cmp70 = icmp eq i64 %5, 0
  %6 = and i64 %0, 280375465082880
  %cmp76 = icmp eq i64 %6, 0
  %7 = and i64 %0, 71776119061217280
  %cmp82 = icmp eq i64 %7, 0
  %cmp88 = icmp eq i32 %conv21, %conv45
  %conv92 = select i1 %cmp, i64 255, i64 0
  %conv93 = select i1 %cmp52, i64 65280, i64 0
  %or = or i64 %conv92, %conv93
  %conv95 = select i1 %cmp58, i64 16711680, i64 0
  %or97 = or i64 %or, %conv95
  %conv98 = select i1 %cmp64, i64 4278190080, i64 0
  %or100 = or i64 %or97, %conv98
  %conv101 = select i1 %cmp70, i64 1095216660480, i64 0
  %or103 = or i64 %or100, %conv101
  %conv104 = select i1 %cmp76, i64 280375465082880, i64 0
  %or106 = or i64 %or103, %conv104
  %conv107 = select i1 %cmp82, i64 71776119061217280, i64 0
  %or109 = or i64 %or106, %conv107
  %conv110 = select i1 %cmp88, i64 -72057594037927936, i64 0
  %or112 = or i64 %or109, %conv110
  ret i64 %or112

; CHECK-LABEL: @test64
; CHECK: cmpb 3, 3, 4
; CHECK-NOT: rldicl
; CHECK: blr
}

attributes #0 = { nounwind readnone }

