def custom_max(*_list):
    result = _list[0]
    # 첫번째 원소와 두번째 원소의 값을 비교하여 큰 값을 출력하는 식을 풀어둔 것
    if _list[0] > _list[1]:
        result= _list[0]
    else:
        result=_list[1]

    # result와 세번째 원소를 비교
    if result > _list[2]:
        result = result
    else:
        reuslt = _list[2]