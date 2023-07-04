#!/bin/bash

function_array=(
    acos
    asin
    atan
    atan2
    cos
    sin
    tan
    acosh
    atanh
    cosh
    sinh
    tanh
    exp
    exp2
    expm1
    frexp
    ilogb
    ldexp
    log
    log10
    log1p
    log2
    logb
    modf
    scalbn
    scalbln
    cbrt
    fabs
    hypot
    pow
    sqrt
    erf
    erfc
    lgamma
    tgamma
    ceil
    floor
    nearbyint
    rint
    lrint
    llrint
    round
    lround
    llround
    trunc
    fmod
    remainder
    remquo
    copysign
    nan
    nextafter
    fdim
    fmax
    fmin
    fma

    acosf
    asinf
    atanf
    atan2f
    cosf
    sinf
    tanf
    acoshf
    asinhf
    atanhf
    coshf
    sinhf
    tanhf
    expf
    exp2f
    expm1f
    frexpf
    ilogbf
    ldexpf
    logf
    log10f
    log1pf
    log2f
    logbf
    modff
    scalbnf
    scalblnf
    cbrtf
    fabsf
    hypotf
    powf
    sqrtf
    erff
    erfcf
    lgammaf
    tgammaf
    ceilf
    floorf
    nearbyintf
    rintf
    lrintf
    llrintf
    roundf
    lroundf
    llroundf
    truncf
    fmodf
    remainderf
    remquof
    copysignf
    nanf
    nextafterf
    fdimf
    fmaxf
    fminf
    fmaf
)

objdump=objdump

application=./qualification/code/app.exe
coverage_file=./qualification/code/app.exe.csv

asm_folder=./qualification/asm
pdf_folder=./qualification/pdf

mkdir -p $asm_folder
mkdir -p $pdf_folder

for i in ${function_array[@]}
do
  $objdump -d $application | sed -ne '/<'$i'>:/,/^$/p' > $asm_folder/$i.asm
  python -m ocgraph -c $coverage_file -d 'OBJDUMP' -a sparc -f $asm_folder/$i.asm
done

mv *.pdf $pdf_folder/
rm -f *.gv
