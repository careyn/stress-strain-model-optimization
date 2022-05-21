from alpha import alpha_SF420

def a_SF420(T, Tref, Ev, Ed):
    #WLF constants c1[] c2[K]
    #c1=382.2 c2=3539.3

    #linear coefficient of thermal expansion [1/K]
    a_1_1, a_1_2, a_1_3 = alpha_SF420(T)
    #volumetric coefficient of thermal expansion [1/K]
    alphav = a_1_1 + a_1_2 + a_1_3

    #fractional free volume at glass transition
    #fref=c2*alphav
    fref = 1.691333

    #apparent activation Energy [K]
    #B=c1*2.303*fref
    B = 1601.5347

    #volumetric strain coefficient
    deltav = 1
    #distortion strain coefficient
    deltad = 0.45013846

    #shift factor
    a = 10**((-B/(2.303*fref)) * (alphav*(T-Tref)+deltav*Ev+deltad*Ed) / (fref + alphav*(T-Tref) + deltav*Ev + deltad*Ed))

    return a
