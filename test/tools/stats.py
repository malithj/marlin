import subprocess
import re
import numpy as np
import pandas as pd


def get_stats(m: np.int64, n: np.int64, k: np.int64, iterations: np.int64,
              mode: np.int64, sparsity: float = 0):
    """
    Computes cache stats
    """
    m = str(m)
    n = str(n)
    k = str(k)
    iterations = str(iterations)
    mode = str(mode)
    sparsity = str(sparsity)
    out = subprocess.Popen(['perf', 'stat',
                            # MEM_LOAD_RETIRED.L1_HIT
                            '-e cpu/config=0x5201d1,name=L1-hits/',
                            # MEM_LOAD_RETIRED.L1_MISS
                            '-e cpu/config=0x5308d1,name=L1-misses/',
                            # icache hits ICACHE_64B:IFTAG_HIT
                            '-e cpu/config=0x530183,name=L1-icache-hits/',
                            # icache miss ICACHE_64B:IFTAG_MISS
                            '-e cpu/config=0x530283,name=L1-icache-misses/',
                            # MEM_LOAD_RETIRED.L2_HIT
                            '-e cpu/config=0x5302d1,name=L2-hits/',
                            # MEM_LOAD_RETIRED.L2_MISS
                            '-e cpu/config=0x5310d1,name=L2-misses/',
                            # MEM_LOAD_RETIRED.L3_HIT
                            '-e cpu/config=0x5304d1,name=L3-hits/',
                            # MEM_LOAD_RETIRED.L3_MISS
                            '-e cpu/config=0x5320d1,name=L3-misses/',
                            '-e dTLB-loads',
                            '-e dTLB-load-misses',
                            '-e iTLB-loads',
                            '-e iTLB-load-misses',
                            '-e page-faults',
                            '-e minor-faults',
                            '-e major-faults',
                            'build/perf_marlin', m, n, k, iterations, mode, sparsity],
                           stdout=subprocess.PIPE,
                           stderr=subprocess.STDOUT)
    stdout, stderr = out.communicate()
    if stderr is not None:
        raise "exception occurred while executing perf"
    stdout = stdout.decode('utf-8')
    splitted = re.split(r'Performance counter stats for', stdout)
    perf_output = splitted[1]
    perf_lines = perf_output.split('\n')
    perf_lines = [p.rstrip().lstrip() for p in perf_lines]
    perf_lines = list(filter(lambda p: p != '', perf_lines))
    num_of_type = np.zeros(15, dtype=np.int64)
    # to extract out relevant information use the following indices
    # L1-dcache-hits            : 2
    # L1-dcache-misses          : 3
    # L1-icache-hits            : 4
    # L1-icache-misses          : 5
    # L2-hits                   : 6
    # L2-misses                 : 7
    # L1-dcache-hits            : 8
    # L1-dcache-misses          : 9
    # dTLB-loads                : 10
    # dTLB-load-misses          : 11
    # iTLB-loads                : 12
    # iTLB-load-misses          : 13
    # page-faults               : 14
    # minor-faults              : 15
    # major-faults              : 16
    for s in range(1, 16):
        value_str = perf_lines[s].split(' ')[0]
        value_str = value_str.replace(',', '')
        try:
            value = np.int64(value_str)
        except:
            value = -1
        num_of_type[s - 1] = value
    second_str = perf_lines[17].split(' ')[0]
    seconds_elapsed = np.float(second_str)
    stats = num_of_type
    return stats


def iterate_over_matrix_sizes(mat_m_start: np.int64, mat_m_end: np.int64,
                              mat_m_inc: np.int64, mat_n_start: np.int64, mat_n_end: np.int64,
                              mat_n_inc: np.int64, mat_k: np.int64,
                              sparsity: np.int64,
                              iterations: np.int64):
    num_m_mat = np.int64((mat_m_end - mat_m_start) / mat_m_inc)
    num_n_mat = np.int64((mat_n_end - mat_n_start) / mat_n_inc)
    num_modes = 8
    stat_count = 15
    results = np.zeros((num_m_mat * num_n_mat * num_modes, 3 + stat_count),
                       dtype=np.int64)
    for kk, mat_n in enumerate(range(mat_n_start, mat_n_end, mat_n_inc)):
        for i, mat_m in enumerate(range(mat_m_start, mat_m_end, mat_m_inc)):
            m = mat_m
            n = mat_n
            k = mat_k
            for j, mode in enumerate(range(num_modes)):
                stats = get_stats(m, n, k, iterations, mode, sparsity)
                results[kk * num_modes * num_m_mat + i *
                        num_modes + j][3:3 + stat_count] = stats
                results[kk * num_modes * num_m_mat + i * num_modes + j][0] = m
                results[kk * num_modes * num_m_mat + i * num_modes + j][1] = n
                results[kk * num_modes * num_m_mat + i * num_modes + j][2] = k
    col_names = ['M', 'N', 'K', 'L1-DCACHE-HITS', 'L1-DCACHE-MISSES',
                 'L1-ICACHE-HITS', 'L1-ICACHE-MISSES', 'L2-HITS',
                 'L2-MISSES', 'L3-HITS',
                 'L3-MISSES', 'DTLB-LOADS', 'DTLB-LOAD-MISSES', 'ITLB-LOADS', 'ITLB-LOAD-MISSES', 'PAGE-FAULTS', 'MINOR-FAULTS', 'MAJOR-FAULTS']
    df = pd.DataFrame(data=results, columns=col_names)
    df = df.replace(-1, np.nan)
    modes_list = ['oneDNN dynamic', 'oneDNN static', 'oneDNN sgemm',
                  'MARLIN', 'Intel MKL', 'LIBXSMM', 'Eigen', 'MKL sgemm']
    df.index.name = 'IDX'
    df.insert(3, 'MODE', np.tile(np.asarray(modes_list, dtype=np.object),
                                 num_m_mat * num_n_mat))
    df.to_csv('build/results/stats_{0:}_{1:}_{2:}_{3:}_{4:}_{5:}_{6:}_{7:.2f}_{8:}.csv'.format
              (mat_m_start, mat_m_end, mat_m_inc, mat_n_start, mat_n_end, mat_n_inc, k,  sparsity, iterations))


def main():
    iterate_over_matrix_sizes(1, 51, 1, 80, 120, 10, 100, 0, 1000)


if __name__ == '__main__':
    main()
