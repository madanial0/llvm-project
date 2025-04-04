; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer,dce -S -mtriple=x86_64-apple-macosx10.8.0 -mcpu=corei7-avx | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.8.0"

; At this point we can't vectorize only parts of the tree.

define i32 @test(ptr nocapture %A, ptr nocapture %B) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x i8>, ptr [[B:%.*]], align 1
; CHECK-NEXT:    [[TMP2:%.*]] = add <2 x i8> [[TMP1]], splat (i8 3)
; CHECK-NEXT:    [[TMP3:%.*]] = sitofp <2 x i8> [[TMP2]] to <2 x double>
; CHECK-NEXT:    [[TMP4:%.*]] = fmul <2 x double> [[TMP3]], [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = fadd <2 x double> [[TMP4]], splat (double 1.000000e+00)
; CHECK-NEXT:    [[TMP6:%.*]] = fmul <2 x double> [[TMP5]], [[TMP5]]
; CHECK-NEXT:    [[TMP7:%.*]] = fadd <2 x double> [[TMP6]], splat (double 1.000000e+00)
; CHECK-NEXT:    [[TMP8:%.*]] = fmul <2 x double> [[TMP7]], [[TMP7]]
; CHECK-NEXT:    [[TMP9:%.*]] = fadd <2 x double> [[TMP8]], splat (double 1.000000e+00)
; CHECK-NEXT:    [[TMP10:%.*]] = fmul <2 x double> [[TMP9]], [[TMP9]]
; CHECK-NEXT:    [[TMP11:%.*]] = fadd <2 x double> [[TMP10]], splat (double 1.000000e+00)
; CHECK-NEXT:    [[TMP12:%.*]] = fmul <2 x double> [[TMP11]], [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = fadd <2 x double> [[TMP12]], splat (double 1.000000e+00)
; CHECK-NEXT:    store <2 x double> [[TMP13]], ptr [[A:%.*]], align 8
; CHECK-NEXT:    ret i32 undef
;
entry:
  %0 = load i8, ptr %B, align 1
  %arrayidx1 = getelementptr inbounds i8, ptr %B, i64 1
  %1 = load i8, ptr %arrayidx1, align 1
  %add = add i8 %0, 3
  %add4 = add i8 %1, 3
  %conv6 = sitofp i8 %add to double
  %conv7 = sitofp i8 %add4 to double
  %mul = fmul double %conv6, %conv6
  %add8 = fadd double %mul, 1.000000e+00
  %mul9 = fmul double %conv7, %conv7
  %add10 = fadd double %mul9, 1.000000e+00
  %mul11 = fmul double %add8, %add8
  %add12 = fadd double %mul11, 1.000000e+00
  %mul13 = fmul double %add10, %add10
  %add14 = fadd double %mul13, 1.000000e+00
  %mul15 = fmul double %add12, %add12
  %add16 = fadd double %mul15, 1.000000e+00
  %mul17 = fmul double %add14, %add14
  %add18 = fadd double %mul17, 1.000000e+00
  %mul19 = fmul double %add16, %add16
  %add20 = fadd double %mul19, 1.000000e+00
  %mul21 = fmul double %add18, %add18
  %add22 = fadd double %mul21, 1.000000e+00
  %mul23 = fmul double %add20, %add20
  %add24 = fadd double %mul23, 1.000000e+00
  %mul25 = fmul double %add22, %add22
  %add26 = fadd double %mul25, 1.000000e+00
  store double %add24, ptr %A, align 8
  %arrayidx28 = getelementptr inbounds double, ptr %A, i64 1
  store double %add26, ptr %arrayidx28, align 8
  ret i32 undef
}
