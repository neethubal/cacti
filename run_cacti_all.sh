
configs=(l1_32kB_4way_22nm_fast l1_32kB_4way_22nm_normal l1_32kB_4way_22nm_sequential
        l2_256kB_8way_22nm_fast l2_256kB_8way_22nm_normal l2_256kB_8way_22nm_sequential
        l3_2MB_16way_22nm_fast l3_2MB_16way_22nm_normal l3_2MB_16way_22nm_sequential
        l3_4MB_16way_22nm_fast l3_4MB_16way_22nm_normal l3_4MB_16way_22nm_sequential
        l3_8MB_16way_22nm_fast l3_8MB_16way_22nm_normal l3_8MB_16way_22nm_sequential
        l3_16MB_16way_22nm_fast l3_16MB_16way_22nm_normal l3_16MB_16way_22nm_sequential
        #l3_8MB_16way_22nm_fast_NUCA l3_8MB_16way_22nm_normal_NUCA l3_8MB_16way_22nm_sequential_NUCA
        )

rm memplex_configs/outputs/summary

for config in "${configs[@]}"
do
    echo ${config}
    ./cacti -infile memplex_configs/${config}.cfg > memplex_configs/outputs/${config}.out 

    access_mode=$(echo $config | awk -F'_' '{print $NF}')

    cache_size=$(grep "Cache size" memplex_configs/outputs/${config}.out | head -1 | awk -F ":" '{print $2}')
    associativity=$(grep "Associativity" memplex_configs/outputs/${config}.out | head -1 | awk -F ":" '{print $2}')
    technology=$(grep "Technology size" memplex_configs/outputs/${config}.out | awk -F ":" '{print $2}')
    access_time=$(grep "Access time" memplex_configs/outputs/${config}.out | awk -F ":" '{print $2}')
    cycle_time=$(grep "Cycle time" memplex_configs/outputs/${config}.out | awk -F ":" '{print $2}')
    data_side=$(grep "Data side" memplex_configs/outputs/${config}.out | awk -F ":" '{print $2}')
    tag_side=$(grep "Tag side" memplex_configs/outputs/${config}.out | awk -F ":" '{print $2}')

    echo "${access_mode}, ${config}, ${cache_size}, ${associativity}, ${technology}, ${access_time}, ${cycle_time}, ${data_side}, ${tag_side}" >> memplex_configs/outputs/summary
done
