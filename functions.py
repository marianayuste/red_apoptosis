import numpy as np
import itertools

def rule2table(rule, #string de la regla lógica
               nodes #lista con todos los nodos del modelo
              ):
    '''crear tabla de verdad a partir de una regla lógica
    devuelve una lista donde cada elemento representa un renglón
    de la tabla de verdad (incluyendo su resultado al final)
    '''
    
    #obtener los reguladores
    boo = ['&','|']
    sep = ['(',')',' ','!']
    r = rule
    for s in sep: 
        r = r.replace(s,'')
    for b in boo:
        r = r.replace(b,',')
    reg = []
    for a in r.split(','):
        if a != '' and a not in reg:
            reg.append(a)
    #organizar los reguladores según como aparecen en la lista nodos
    reguladores = []
    for a in nodes:
        if a in reg:
            reguladores.append(a)
    
    #crear todos los posibles edos iniciales con los reguladores
    lista = list(itertools.product([1,0], repeat = len(reguladores))) 
    #convertir los edos iniciales a una lista de strings
    edos_iniciales = []
    for a in range(len(lista)):
        e = ''
        for b in lista[a]:
            e = e + str(b)
        edos_iniciales.append(e)
    
    # tabla de verdad de 1s y 0s 
    #con cada edo inicial (valores organizados según lista nodos) 
    #y el resultado del nodo al final
    truth_table = []
    for a in edos_iniciales:
        #guardar edo de cada regulador
        edos = {}
        for x in range(len(reguladores)):
            edos[reguladores[x]] = a[x]

        #resolver regla según edos
        sol = rule.replace('!', 'not ').replace('~', 'not ').replace('&',' and ').replace('|',' or ')
        for y in reguladores:
            sol = sol.replace(y, edos[y])

        #agregar al final de cada edo inicial su resultado
        #se guardará ese string completo en truth_table
        truth_table.append(a+str(eval(sol)).replace('False','0').replace('True','1'))
    
    return truth_table, reguladores

def table2rule(truth_table, #lista de renglones de la tabla (incluyendo resultado al final)
                  regulators #lista de los reguladores (como los regresa rule2table)
                 ):
    '''función para crear una regla lógica escrita igual que las de Griffin. 
    A partir de una tabla de verdad de ceros y unos (como la entrega rule2table)
    en esta regla lógica nueva cada renglón de la tabla de verdad 
    se anota tal cual en la regla truth_table: 
    '''
    
    
    new_rule = ''
    for a in truth_table:
        if a[-1] == '1': #crear una regla si el resultado es 1
            #para ello se toman los nodos que se encuetren en 1
            reglita = ''
            #agregar estado de cada nodo a la reglita
            for n in range(len(a)-1): #para cada regulador
                if a[n] == '1':
                    reglita = reglita + '&' + regulators[n]
                elif a[n] == '0':
                    reglita = reglita + '&~' + regulators[n]
            reglita = '('+reglita[1:]+')'
            new_rule = new_rule+'|'+reglita
    new_rule = new_rule[1:]
    return new_rule

def regla_tipo_griffin(regla_logica, #string de la regla lógica
                   nodos #lista con todos los nodos del modelo
                  ):
    '''transformar una regla lógica a notación como la regresa griffin'''
    
    tabla = rule2table(regla_logica,nodos)
    return table2rule(tabla[0],tabla[1])

def reglas_perturbadas(regla):
    '''Crear todas las posibles perturbaciones tipo bitflip a un nodo
        la regla input es un string con la regla original de un nodo usando simbolos &,| y ~
        y debe tener notacion tipo griffin (pasarla antes por regla_tipo_griffin)
    '''
    
    #lista con los renglones de la tabla de verdad que tiene la regla (donde el nodo = 1)
    r = regla.replace('(','').replace(')','').split('|')

    #Sacar los nodos que regulan al gen actual
    reguladores = regla
    quitar = '()~'
    for a in quitar:
        reguladores = reguladores.replace(a,'')
    #sacar solo los nodos y quitar repeticiones:
    reguladores = list(dict.fromkeys(reguladores.split('|')[0].split('&')))

    #lista con todos los renglones de la tabla de verdad
    total_r = []
    comb = list(itertools.product(['~',''], repeat = len(reguladores)))
    for a in comb:
        c = ''
        for b in range(len(reguladores)):
            c = c + (a[b] + reguladores[b]) + '&'
        total_r.append(c[:-1])

    #lista con los renglones de la tabla de verdad que tiene la anti-regla (donde el nodo = 0)
    not_r = [] 
    for a in total_r:
        if a not in r:
            not_r.append(a)
    
    ### Hacer las reglas perturbadas ###
    per = {} #diccionario con listas de los renglones donde el nodo = 1 en las perturbaciones
    for a in range(len(total_r)):
        per[a] = []
    # Quitar uno por uno los renglones de r (la regla original)
    for a in range(len(r)):
        for b in range(len(r)):
            if b != a:
                per[a].append(r[b])
    # Agregar uno por uno los renglones de not_r
    for a in range(len(not_r)):
        per[len(r)+a] = regla.replace('(','').replace(')','').split('|')
        per[len(r)+a].append(not_r[a])
    # Convertir las reglas perturbadas a un string similar al original
    reglas_per = {}  # diccionario con las reglas perturbadas a usar
    for a in per:
        q = ''
        for b in per[a]:
            q = q + '(' + b + ')' + '|'
        if q[:-1] == '':
            reglas_per[a] = '0'
        else:
            reglas_per[a] = q[:-1]

    return(reglas_per)
