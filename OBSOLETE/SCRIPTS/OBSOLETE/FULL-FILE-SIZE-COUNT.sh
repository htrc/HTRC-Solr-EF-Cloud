for d in coo   dul1  gri  iau  inu   ku01     loc  mdp   miun  mou   ncs1  nnc1  nyp  psia  pur1  uc1  ucm  udel  ufl2  uiug  uma  usu  wau  yale coo1  emu   hvd  ien  keio  listing  mcg  miua  mmet  nc01  njp   nnc2  osu  pst   txa   uc2  ucw  ufl1  uiuc  uiuo  umn  uva  wu   yul  ; do 
  echo $d ; 
  (find /data/features/ef-full/$d -type f -printf "%s\n" > ef-full-$d.txt) ; 
done

echo "Finished!"
