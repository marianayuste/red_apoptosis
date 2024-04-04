from functions import regla_tipo_griffin

#nodos
n = ['ICL','FAcore','FANCD2I','Nuc1','RNF4','Nuc2','ADD','DSB','TLS','FAhrr','HRR2','NHEJ','TNFa','p38MAPK','ATR','ATM','p530','MDM2','p53a0','p21','p53aRE','p53k0','p53kRE','CASP3','IAP','Wip1','CDK1/AurA','Plk1','CDC25','CycB/CDK1']
nodes = []
for i in n: #cambiar '/' por '_'
    nodes.append(i.replace('/','_'))

#regulaciones de cada nodo
f = open('original.txt','r').read()
rules = f.split('\n')[1:len(nodes)+1] #quitando 1er y ultimo renglón (con 'targets,factors' y espacio)
rules = [k.replace('/','_') for k in rules]
for i in range(len(rules)):
    rules[i] = rules[i].split(', ')[1]

#número total de reglas de cada nodo
total_rules = []
boo = ['&','|']
sep = ['(',')',' ','!']
for i in range(len(nodes)):
    r = rules[i]
    for s in sep:
        r = r.replace(s,'')
    for b in boo:
        r = r.replace(b,',')
    r = r.split(',')
    total_rules.append(len(r))

#obtener total de renglones de la tabla de verdad de cada nodo
'''
renglones = []
for n in range(len(nodes)):
    table = rule2table(rules[n],nodes)
    renglones.append(len(table[0]))
'''
#del forloop de arriba obtuve la sig lista:
renglones = [8,64,8,8,4,256,16,256,4,1024,32,128,32,4,64,128,64,8,64,4,16,524288,32,8,2,4,64,128,64,64]

#regla del nodo p53k0 (es enorme, mejor ya tenerla guardada)
nodo = 'p53k0'
i_n = nodes.index(nodo)
regla = regla_tipo_griffin(rules[i_n],nodes).split('|')
open('regla_p53k0.txt','w').close()
f = open('regla_p53k0.txt','a')
for r in regla:
    f.write(r)
    f.write('\n')

print('nodos en nodes\nregulaciones en rules\ntotal de regulaciones en total_rules\ntotal de renglones de la tabla de verdad de cada nodo en renglones')
