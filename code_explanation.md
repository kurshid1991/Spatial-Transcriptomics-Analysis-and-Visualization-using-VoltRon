# Explanation of code
Here is an attempt to explain what is going on, and why we do what we do 😊

```r
options(java.parameters = "-Xmx8g")
library(VoltRon)
```
Voltron is JAVA dependent.

- options(java.parameters = "-Xmx8g") increases Java's maximum memory allocation to 8GB for better performance.

- library(VoltRon) loads the VoltRon package, which likely depends on Java for its functionality.

```r
####
# Visium Analysis ####
####

####
## Import Data in VoltRon ####
####

# Dependencies
if(!requireNamespace("rhdf5"))
  BiocManager::install("rhdf5")
library(rhdf5)

# import Breast Cancer Visium data
bc_visium <- importVisium("D:/Compgen2025/module2/workshop/data/BreastCancer/Visium",
                          sample_name = "bc_visium") # path to your visium folder under data
```

Now we use SampleMetadata(bc_visium), which retrieves and displays metadata associated with the bc_visium object, likely a Spatial Transcriptomics dataset analyzed using the VoltRon package.
```r
# sample metadata
SampleMetadata(bc_visium)
```
##### Breakdown of the output:
               Assay    Layer    Sample
      Assay1 Visium Section1 bc_visium1
- Assay1 → Refers to the specific assay type used (e.g., Visium, 10x Genomics).
- Visium → Indicates the spatial transcriptomics platform (10x Genomics Visium).
- Section1 → Represents the tissue section being analyzed.
- bc_visium → The sample name or object storing the dataset.

This metadata helps in organizing and processing spatial transcriptomics data for downstream analysis.

```r
View(Metadata(bc_visium))
```
Output:

| id                                  | Count | assay_id                         | Assay  | Layer  | Sample    |
|-------------------------------------|-------|----------------------------------|--------|--------|-----------|
| AACACCTACTATCGAA-1_Assay1           | 12675 | Assay1                          | Assay1 | Visium | Section1  |
| AACACGTGCATCGCAC-1_Assay1           | 7886  | Assay1                          | Assay1 | Visium | Section1  |
| AACACTTGGCAAGGAA-1_Assay1           | 32614 | Assay1                          | Assay1 | Visium | Section1  |
| AACAGGAAGAGCATAG-1_Assay1           | 7484  | Assay1                          | Assay1 | Visium | Section1  |
| AACAGGATTCATAGTT-1_Assay1           | 6694  | Assay1                          | Assay1 | Visium | Section1  |
| AACAGGCCAACGATTA-1_Assay1           | 4864  | Assay1                          | Assay1 | Visium | Section1  |
| AACAGGTTATTGCACC-1_Assay1           | 25598 | Assay1                          | Assay1 | Visium | Section1  |
| AACAGGTTCACCGAAG-1_Assay1           | 24967 | Assay1                          | Assay1 | Visium | Section1  |
| AACAGTCAGGCTCCGC-1_Assay1           | 44387 | Assay1                          | Assay1 | Visium | Section1  |
| AACAGTCCACGCGGTG-1_Assay1           | 27580 | Assay1                          | Assay1 | Visium | Section1  |
.
.
.
.
.
.

View(Metadata(bc_visium)) allows you to inspect the metadata in an interactive window within RStudio.

 ```r
 # features 
vrFeatures(bc_visium)
```
Output:

   [1] "SAMD11"     "NOC2L"      "KLHL17"     "PLEKHN1"    "PERM1"      "HES4"      
   [7] "ISG15"      "AGRN"       "RNF223"     "C1orf159"   "TTLL10"     "TNFRSF18"  
  [13] "TNFRSF4"    "SDF4"       "B3GALT6"    "C1QTNF12"   "UBE2J2"     "SCNN1D"    
  [19] "ACAP3"      "PUSL1"      "INTS11"     "CPTP"       "TAS1R3"     "DVL1"      
  [25] "MXRA8"      "AURKAIP1"   "CCNL2"      "ANKRD65"    "TMEM88B"    "VWA1"      
  [31] "ATAD3C"     "ATAD3B"     "ATAD3A"     "TMEM240"    "SSU72"      "FNDC10"    
  [37] "MIB2"       "MMP23B"     "CDK11B"     "CDK11A"     "NADK"       "GNB1"      
  [43] "CALML6"     "TMEM52"     "CFAP74"     "GABRD"      "PRKCZ"      "FAAP20"    
  [49] "SKI"        "RER1"       "PEX10"      "PLCH2"      "PANK4"      "HES5"      
  [55] "TNFRSF14"   "PRXL2B"     "MMEL1"      "ACTRT2"     "PRDM16"     "ARHGEF16"  
  [61] "MEGF6"      "TPRG1L"     "WRAP73"     "TP73"       "CCDC27"     "SMIM1"     
  [67] "LRRC47"     "CEP104"     "DFFB"       "C1orf174"   "AJAP1"      "NPHP4"     
  [73] "KCNAB2"     "CHD5"       "RNF207"     "ICMT"       "GPR153"     "ACOT7"     
  [79] "HES2"       "ESPN"       "TNFRSF25"   "PLEKHG5"    "NOL9"       "TAS1R1"    
  [85] "ZBTB48"     "KLHL21"     "PHF13"      "THAP3"      "DNAJC11"    "CAMTA1"    
  [91] "VAMP3"      "PER3"       "UTS2"       "TNFRSF9"    "ERRFI1"     "SLC45A1"   
  [97] "RERE"       "ENO1"       "CA6"        "SLC2A7"     "SLC2A5"     "GPR157"    
 [103] "H6PD"       "SPSB1"      "SLC25A33"   "TMEM201"    "PIK3CD"     "CLSTN1"    
 [109] "CTNNBIP1"   "LZIC"       "NMNAT1"     "RBP7"       "UBE4B"      "KIF1B"     
 [115] "PGD"        "CENPS"      "CORT"       "DFFA"       "PEX14"      "CASZ1"     
 [121] "C1orf127"   "MASP2"      "SRM"        "EXOSC10"    "MTOR"       "ANGPTL7"   
 [127] "UBIAD1"     "DISP3"      "FBXO2"      "FBXO44"     "FBXO6"      "MAD2L2"    
 [133] "DRAXIN"     "AGTRAP"     "C1orf167"   "MTHFR"      "CLCN6"      "NPPA"      
 [139] "NPPB"       "KIAA2013"   "PLOD1"      "MFN2"       "MIIP"       "TNFRSF8"   
 [145] "TNFRSF1B"   "VPS13D"     "DHRS3"      "AADACL4"    "AADACL3"    "C1orf158"  
 [151] "PRAMEF12"   "PRAMEF1"    "PRAMEF11"   "PRAMEF2"    "PRAMEF4"    "PRAMEF10"  
 [157] "PRAMEF6"    "PRAMEF27"   "HNRNPCL3"   "HNRNPCL2"   "PRAMEF13"   "PRAMEF18"  
 [163] "PRAMEF8"    "PRAMEF33"   "PRAMEF15"   "PRAMEF14"   "PRAMEF19"   "PRAMEF20"  
 [169] "LRRC38"     "PDPN"       "PRDM2"      "KAZN"       "TMEM51"     "FHAD1"     
 [175] "EFHD2"      "CTRC"       "CELA2A"     "CELA2B"     "CASP9"      "DNAJC16"   
 [181] "AGMAT"      "DDI2"       "PLEKHM2"    "SLC25A34"   "TMEM82"     "FBLIM1"    
 [187] "UQCRHL"     "SPEN"       "ZBTB17"     "SRARP"      "HSPB7"      "CLCNKA"    
 [193] "CLCNKB"     "FAM131C"    "EPHA2"      "ARHGEF19"   "CPLANE2"    "FBXO42"    
 [199] "SZRD1"      "SPATA21"    "NECAP2"     "NBPF1"      "CROCC"      "MFAP2"     
 [205] "ATP13A2"    "SDHB"       "PADI2"      "PADI1"      "PADI3"      "PADI4"     
 [211] "PADI6"      "RCC2"       "ARHGEF10L"  "ACTL8"      "IGSF21"     "KLHDC7A"   
 [217] "PAX7"       "TAS1R2"     "ALDH4A1"    "IFFO2"      "UBR4"       "EMC1"      
 [223] "MRTO4"      "AKR7A2"     "SLC66A1"    "CAPZB"      "MICOS10"    "NBL1"      
 [229] "HTR6"       "TMCO4"      "RNF186"     "OTUD3"      "PLA2G2E"    "PLA2G2A"   
 [235] "PLA2G5"     "PLA2G2D"    "PLA2G2F"    "PLA2G2C"    "UBXN10"     "VWA5B1"    
 [241] "CAMK2N1"    "MUL1"       "FAM43B"     "CDA"        "PINK1"      "DDOST"     
 [247] "KIF17"      "SH2D5"      "HP1BP3"     "EIF4G3"     "ECE1"       "NBPF3"     
 [253] "ALPL"       "RAP1GAP"    "USP48"      "HSPG2"      "CELA3B"     "CELA3A"    
 [259] "WNT4"       "ZBTB40"     "EPHA8"      "C1QA"       "C1QC"       "C1QB"      
 [265] "EPHB2"      "LACTBL1"    "TEX46"      "KDM1A"      "LUZP1"      "HTR1D"     
 [271] "HNRNPR"     "ZNF436"     "TCEA3"      "ASAP3"      "E2F2"       "ID3"       
 [277] "ELOA"       "PITHD1"     "GALE"       "HMGCL"      "FUCA1"      "CNR2"      
 [283] "PNRC2"      "SRSF10"     "MYOM3"      "IL22RA1"    "IFNLR1"     "GRHL3"     
 [289] "STPG1"      "NIPAL3"     "RCAN3"      "NCMAP"      "SRRM1"      "CLIC4"     
 [295] "RUNX3"      "SYF2"       "RSRP1"      "RHD"        "TMEM50A"    "RHCE"      
 [301] "MACO1"      "LDLRAP1"    "MAN1C1"     "SELENON"    "MTFR1L"     "AUNIP"     
 [307] "PAQR7"      "STMN1"      "PAFAH2"     "EXTL1"      "SLC30A2"    "TRIM63"    
 [313] "PDIK1L"     "FAM110D"    "C1orf232"   "AL391650.1" "ZNF593"     "CNKSR1"    
 [319] "CATSPER4"   "CEP85"      "SH3BGRL3"   "UBXN11"     "CD52"       "CRYBG2"    
 [325] "ZNF683"     "LIN28A"     "DHDDS"      "ARID1A"     "PIGV"       "ZDHHC18"   
 [331] "SFN"        "GPN2"       "GPATCH3"    "NUDC"       "NR0B2"      "KDF1"      
 [337] "TRNP1"      "TENT5B"     "SLC9A1"     "WDTC1"      "TMEM222"    "SYTL1"     
 [343] "MAP3K6"     "FCN3"       "CD164L2"    "GPR3"       "WASF2"      "AHDC1"     
 [349] "FGR"        "IFI6"       "FAM76A"     "STX12"      "PPP1R8"     "THEMIS2"   
 [355] "RPA2"       "SMPDL3B"    "XKR8"       "EYA3"       "PTAFR"      "DNAJC8"    
 [361] "ATP5IF1"    "SESN2"      "MED18"      "PHACTR4"    "RCC1"       "TRNAU1AP"  
 [367] "TAF12"      "RAB42"      "GMEB1"      "YTHDF2"     "OPRD1"      "EPB41"     
 [373] "TMEM200B"   "SRSF4"      "MECR"       "PTPRU"      "MATN1"      "LAPTM5"    
 [379] "SDC3"       "PUM1"       "NKAIN1"     "SNRNP40"    "ZCCHC17"    "FABP3"     
 [385] "SERINC2"    "TINAGL1"    "HCRTR1"     "PEF1"       "COL16A1"    "ADGRB2"    
 [391] "SPOCD1"     "KHDRBS1"    "TMEM39B"    "KPNA6"      "TXLNA"      "CCDC28B"   
 [397] "IQCC"       "DCDC2B"     "TMEM234"    "EIF3I"      "FAM167B"    "LCK"       
 [403] "HDAC1"      "MARCKSL1"   "TSSK3"      "FAM229A"    "BSDC1"      "ZBTB8B"    
 [409] "ZBTB8A"     "RBBP4"      "SYNC"       "KIAA1522"   "YARS"       "S100PBP"   
 [415] "FNDC5"      "HPCA"       "TMEM54"     "RNF19B"     "AZIN2"      "TRIM62"    
 [421] "ZNF362"     "A3GALT2"    "PHC2"       "ZSCAN20"    "CSMD2"      "HMGB4"     
 [427] "C1orf94"    "SMIM12"     "GJB5"       "GJB4"       "GJB3"       "GJA4"      
 [433] "DLGAP3"     "TMEM35B"    "ZMYM6"      "ZMYM1"      "SFPQ"       "ZMYM4"     
 [439] "KIAA0319L"  "NCDN"       "TFAP2E"     "PSMB2"      "C1orf216"   "CLSPN"     
 [445] "AGO4"       "AGO1"       "AGO3"       "TEKT2"      "ADPRHL2"    "COL8A2"    
 [451] "TRAPPC3"    "MAP7D1"     "THRAP3"     "SH3D21"     "EVA1B"      "STK40"     
 [457] "LSM10"      "OSCP1"      "CSF3R"      "GRIK3"      "ZC3H12A"    "MEAF6"     
 [463] "SNIP1"      "DNALI1"     "GNL2"       "RSPO1"      "C1orf109"   "CDCA8"     
 [469] "EPHA10"     "MANEAL"     "YRDC"       "C1orf122"   "MTF1"       "INPP5B"    
 [475] "SF3A3"      "FHL3"       "UTP11"      "POU3F1"     "RRAGC"      "MYCBP"     
 [481] "GJA9"       "RHBDL2"     "AKIRIN1"    "NDUFS5"     "MACF1"      "BMP8A"     
 [487] "PABPC4"     "HEYL"       "NT5C1A"     "HPCAL4"     "PPIE"       "BMP8B"     
 [493] "OXCT2"      "TRIT1"      "MYCL"       "MFSD2A"     "CAP1"       "PPT1"      
 [499] "RLF"        "TMCO2"      "ZMPSTE24"   "COL9A2"     "SMAP2"      "ZFP69B"    
 [505] "ZFP69"      "EXO5"       "ZNF684"     "RIMS3"      "NFYC"       "KCNQ4"     
 [511] "CITED4"     "CTPS1"      "SLFNL1"     "SCMH1"      "FOXO6"      "EDN2"      
 [517] "HIVEP3"     "GUCA2B"     "GUCA2A"     "FOXJ3"      "RIMKLA"     "ZMYND12"   
 [523] "PPCS"       "CCDC30"     "PPIH"       "YBX1"       "CLDN19"     "P3H1"      
 [529] "TMEM269"    "SVBP"       "ERMAP"      "ZNF691"     "SLC2A1"     "FAM183A"   
 [535] "EBNA1BP2"   "CFAP57"     "TMEM125"    "C1orf210"   "TIE1"       "MPL"       
 [541] "CDC20"      "ELOVL1"     "MED8"       "SZT2"       "HYI"        "PTPRF"     
 [547] "KDM4A"      "ST3GAL3"    "ARTN"       "IPO13"      "DPH2"       "ATP6V0B"   
 [553] "B4GALT2"    "CCDC24"     "SLC6A9"     "KLF17"      "KLF18"      "DMAP1"     
 [559] "ERI3"       "RNF220"     "TMEM53"     "ARMH1"      "KIF2C"      "BEST4"     
 [565] "PLK3"       "TCTEX1D4"   "BTBD19"     "PTCH2"      "EIF2B3"     "HECTD3"    
 [571] "UROD"       "ZSWIM5"     "HPDL"       "MUTYH"      "TOE1"       "TESK2"     
 [577] "CCDC163"    "MMACHC"     "PRDX1"      "AKR1A1"     "NASP"       "CCDC17"    
 [583] "GPBP1L1"    "TMEM69"     "IPP"        "MAST2"      "PIK3R3"     "TSPAN1"    
 [589] "P3R3URF"    "POMGNT1"    "LURAP1"     "RAD54L"     "LRRC41"     "UQCRH"     
 [595] "NSUN4"      "FAAH"       "DMBX1"      "TMEM275"    "KNCN"       "MKNK1"     
 [601] "MOB3C"      "ATPAF1"     "TEX38"      "EFCAB14"    "CYP4B1"     "CYP4A11"   
 [607] "CYP4X1"     "CYP4Z1"     "CYP4A22"    "PDZK1IP1"   "TAL1"       "STIL"      
 [613] "CMPK1"      "FOXE3"      "FOXD2"      "TRABD2B"    "SLC5A9"     "SPATA6"    
 [619] "AGBL4"      "BEND5"      "ELAVL4"     "DMRTA2"     "FAF1"       "CDKN2C"    
 [625] "C1orf185"   "RNF11"      "TTC39A"     "EPS15"      "OSBPL9"     "NRDC"      
 [631] "RAB3B"      "TXNDC12"    "KTI12"      "BTF3L4"     "ZFYVE9"     "CC2D1B"    
 [637] "ORC1"       "PRPF38A"    "TUT4"       "GPX7"       "SHISAL2A"   "COA7"      
 [643] "ZYG11B"     "ZYG11A"     "ECHDC2"     "SCP2"       "PODN"       "SLC1A7"    
 [649] "CPT2"       "CZIB"       "MAGOH"      "LRP8"       "DMRTB1"     "GLIS1"     
 [655] "NDC1"       "YIPF1"      "DIO1"       "HSPB11"     "LRRC42"     "LDLRAD1"   
 [661] "TMEM59"     "TCEANC2"    "CDCP2"      "CYB5RL"     "SSBP3"      "ACOT11"    
 [667] "FAM151A"    "MROH7"      "TTC4"       "PARS2"      "TTC22"      "LEXM"      
 [673] "DHCR24"     "TMEM61"     "BSND"       "PCSK9"      "USP24"      "PLPP3"     
 [679] "PRKAA2"     "FYB2"       "C8A"        "C8B"        "DAB1"       "OMA1"      
 [685] "TACSTD2"    "MYSM1"      "JUN"        "FGGY"       "HOOK1"      "CYP2J2"    
 [691] "C1orf87"    "NFIA"       "TM2D1"      "PATJ"       "L1TD1"      "KANK4"     
 [697] "USP1"       "DOCK7"      "ANGPTL3"    "ATG4C"      "FOXD3"      "ALG6"      
 [703] "ITGB3BP"    "EFCAB7"     "PGM1"       "ROR1"       "UBE2U"      "CACHD1"    
 [709] "RAVER2"     "JAK1"       "AK4"        "DNAJC6"     "LEPROT"     "LEPR"      
 [715] "PDE4B"      "SGIP1"      "TCTEX1D1"   "INSL5"      "WDR78"      "MIER1"     
 [721] "SLC35D1"    "C1orf141"   "IL23R"      "IL12RB2"    "SERBP1"     "GADD45A"   
 [727] "GNG12"      "DIRAS3"     "WLS"        "RPE65"      "DEPDC1"     "LRRC7"     
 [733] "LRRC40"     "SRSF11"     "ANKRD13C"   "HHLA3"      "CTH"        "PTGER3"    
 [739] "ZRANB2"     "NEGR1"      "LRRIQ3"     "FPGT"       "TNNI3K"     "LRRC53"    
 [745] "ERICH3"     "CRYZ"       "TYW3"       "LHX8"       "SLC44A5"    "ACADM"     
 [751] "RABGGTB"    "MSH4"       "ASB17"      "ST6GALNAC3" "ST6GALNAC5" "PIGK"      
 [757] "AK5"        "AC118549.1" "USP33"      "MIGA1"      "NEXN"       "FUBP1"     
 [763] "DNAJB4"     "GIPC2"      "PTGFR"      "IFI44L"     "IFI44"      "ADGRL4"    
 [769] "ADGRL2"     "TTLL7"      "PRKACB"     "SAMD13"     "DNASE2B"    "RPF1"      
 [775] "GNG5"       "SPATA1"     "CTBS"       "SSX2IP"     "LPAR3"      "MCOLN2"    
 [781] "WDR63"      "MCOLN3"     "SYDE2"      "C1orf52"    "BCL10"      "DDAH1"     
 [787] "CCN1"       "ZNHIT6"     "COL24A1"    "ODF2L"      "CLCA2"      "CLCA1"     
 [793] "CLCA4"      "SH3GLB1"    "SELENOF"    "HS2ST1"     "LMO4"       "PKN2"      
 [799] "GTF2B"      "KYAT3"      "RBMXL1"     "GBP3"       "GBP1"       "GBP2"      
 [805] "GBP7"       "GBP4"       "GBP5"       "GBP6"       "LRRC8B"     "LRRC8C"    
 [811] "LRRC8D"     "ZNF326"     "BARHL2"     "ZNF644"     "HFM1"       "CDC7"      
 [817] "TGFBR3"     "BRDT"       "EPHX4"      "BTBD8"      "C1orf146"   "GLMN"      
 [823] "RPAP2"      "GFI1"       "EVI5"       "DIPK1A"     "MTF2"       "TMED5"     
 [829] "CCDC18"     "DR1"        "FNBP1L"     "BCAR3"      "DNTTIP2"    "GCLM"      
 [835] "ABCA4"      "ARHGAP29"   "ABCD3"      "F3"         "SLC44A3"    "CNN3"      
 [841] "ALG14"      "TLCD4"      "RWDD3"      "PTBP2"      "DPYD"       "SNX7"      
 [847] "PLPPR5"     "PLPPR4"     "PALMD"      "FRRS1"      "AGL"        "SLC35A3"   
 [853] "MFSD14A"    "SASS6"      "TRMT13"     "LRRC39"     "DBT"        "RTCA"      
 [859] "CDC14A"     "GPR88"      "VCAM1"      "EXTL2"      "SLC30A7"    "DPH5"      
 [865] "S1PR1"      "OLFM3"      "COL11A1"    "RNPC3"      "AMY2A"      "PRMT6"     
 [871] "NTNG1"      "VAV3"       "SLC25A24"   "FAM102B"    "HENMT1"     "PRPF38B"   
 [877] "FNDC7"      "STXBP3"     "GPSM2"      "CLCC1"      "WDR47"      "TAF13"     
 [883] "TMEM167B"   "C1orf194"   "KIAA1324"   "SARS"       "CELSR2"     "PSRC1"     
 [889] "MYBPHL"     "SORT1"      "PSMA5"      "SYPL2"      "ATXN7L2"    "CYB561D1"  
 [895] "AMIGO1"     "GPR61"      "GNAI3"      "GNAT2"      "AMPD2"      "GSTM1"     
 [901] "GSTM3"      "EPS8L3"     "CSF1"       "AHCYL1"     "STRIP1"     "ALX3"      
 [907] "UBL4B"      "SLC6A17"    "KCNC4"      "RBM15"      "SLC16A4"    "LAMTOR5"   
 [913] "PROK1"      "KCNA10"     "KCNA2"      "KCNA3"      "CD53"       "LRIF1"     
 [919] "DRAM2"      "CEPT1"      "DENND2D"    "CHI3L2"     "CHIA"       "PIFO"      
 [925] "OVGP1"      "WDR77"      "ATP5PB"     "C1orf162"   "TMIGD3"     "ADORA3"    
 [931] "RAP1A"      "INKA2"      "DDX20"      "KCND3"      "CTTNBP2NL"  "WNT2B"     
 [937] "ST7L"       "CAPZA1"     "MOV10"      "RHOC"       "PPM1J"      "TAFA3"     
 [943] "SLC16A1"    "LRIG2"      "MAGI3"      "PHTF1"      "RSBN1"      "PTPN22"    
 [949] "BCL2L15"    "AP4B1"      "DCLRE1B"    "HIPK1"      "OLFML3"     "SYT6"      
 [955] "TRIM33"     "BCAS2"      "DENND2C"    "AMPD1"      "NRAS"       "CSDE1"     
 [961] "SIKE1"      "SYCP1"      "TSHB"       "TSPAN2"     "NGF"        "VANGL1"    
 [967] "CASQ2"      "NHLH2"      "SLC22A15"   "MAB21L3"    "ATP1A1"     "CD58"      
 [973] "IGSF3"      "CD2"        "PTGFRN"     "CD101"      "TTF2"       "TRIM45"    
 [979] "VTCN1"      "MAN1A2"     "TENT5C"     "GDAP2"      "WDR3"       "SPAG17"    
 [985] "TBX15"      "WARS2"      "HAO2"       "HSD3B2"     "HSD3B1"     "ZNF697"    
 [991] "PHGDH"      "HMGCS2"     "REG4"       "ADAM30"     "NOTCH2"     "SEC22B"    
 [997] "PPIAL4A"    "FCGR1B"     "NBPF20"     "PDZK1"     
 [ reached getOption("max.print") -- omitted 17085 entries ]

 - This command retrieves the variable (or detected) features in the bc_visium dataset.
 - The listed genes (e.g., SAMD11, NOC2L, KLHL17, etc.) represent the most variable genes in your dataset, which are often used for downstream analyses such as clustering, differential expression analysis, and visualization.
 - The large number of genes suggests that vrFeatures() has returned a selection of highly expressed or highly variable genes.
  ```r
   ####
# Images ####
####

# images and channels
vrImageChannelNames(bc_visium)
```
Output:

| Assay  | Layer  | Sample  | Spatial  | Channels |
|--------|--------|---------|----------|----------|
| Assay1 | Visium | Section1 | bc_visium | H&E |

This output tells us that:

1. The dataset is from a 10x Genomics Visium assay.
2. It is analyzing Section1 of the sample.
3. The sample is stored in bc_visium.
4. The H&E (Hematoxylin & Eosin) stained image channel is available.

```r
# get images
vrImages(bc_visium)
vrImages(bc_visium, scale.perc = 20)
vrImages(bc_visium, channel = "H&E", scale.perc = 100)
```
Output:

